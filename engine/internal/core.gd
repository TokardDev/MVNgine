extends Node

var modules = {}
var history_stack = []

var current_file_path: String
var file: FileAccess
var current_line_index: int = 0

func init_modules():
	load_modules("game/modules")
	load_modules("engine/modules")
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_resized"))

func execute_command(command: String, args: Array):
	if command in modules:
		var module_instance = modules[command]["instance"]
		var method_name = modules[command]["function"]
		if module_instance.has_method(method_name):
			var callable = Callable(module_instance, method_name)
			callable.callv(args)
		else:
			print("Command not found: ", command)
	else:
		print("Unknown command: ", command)


func load_modules(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".gd") and not dir.current_is_dir():
				var module_script = load(path + "/" + file_name)
				if module_script:
					var module_instance = module_script.new()
					modules.merge(module_instance.get_commands())
					add_child(module_instance)
			file_name = dir.get_next()


func process_parsed_line(parsed: Dictionary) -> void:
	match parsed["type"]:
		"command":
			var parts = parsed["content"].split(" ")
			var command = parts[0]
			var args = parts.slice(1) if parts.size() > 1 else []
			execute_command(command, args)
		
		"character_dialogue":
			Utils.find_node("DialogueBox").change_talking(parsed["character"])
		
		"text":
			Utils.find_node("DialogueBox").update_talking()
			Utils.find_node("DialogueBox").update_text(parsed["text"])
			Utils.find_node("MainText").modulate = "#ffffff"
			save_state()
		
		"narration":
			Utils.find_node("Name").text = ""
			Utils.find_node("DialogueBox").update_text("[i]"+parsed["text"]+"[/i]")
			Utils.find_node("MainText").modulate = "#9c9c9c"
			save_state()

func read_lines() -> void:
	var line = read_next_line()
	var parsed = parse_line(line)
	if parsed["type"] != "text" and parsed["type"] != "narration":
		process_parsed_line(parsed)
		read_lines()
	else:
		process_parsed_line(parsed)


func load_file(file_path: String) -> void:
	if not FileAccess.file_exists(file_path):
		push_error("Can't find .mvn : " + file_path)
		return
	current_file_path = file_path
	file = FileAccess.open(file_path, FileAccess.READ)
	current_line_index = 0
	
	
func read_next_line() -> String:
	if not file:
		push_error("No files open!")
		return ""
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		current_line_index += 1
		if line.is_empty() or line.begins_with("#"):
			continue
		return line
	return ""  # Retourne une chaîne vide si tout est lu


# Fermer le fichier
func close_file() -> void:
	if file:
		file.close()
		file = null

# Analyser une ligne de texte et renvoyer un dictionnaire
func parse_line(line: String) -> Dictionary:
	var result = {}
	if line.begins_with("[b]") or line.begins_with("[i]"):
		result["type"] = "text"
		result["text"] = line
	elif line.begins_with("["):
		# Commande (ex: [bg forest])
		result["type"] = "command"
		result["content"] = line.trim_prefix("[").trim_suffix("]")
	elif line.begins_with(">"):
		# Dialogue d'un personnage
		result["type"] = "character_dialogue"
		result["character"] = line.trim_prefix(">")
	elif line.begins_with("@"):
		# Narration
		result["type"] = "narration"
		result["text"] = line.trim_prefix("@")
	else:
		# Texte normal
		result["type"] = "text"
		result["text"] = line
	return result

func _on_viewport_resized():
	Utils.find_node("MainText").resize_text()
	Utils.find_node("Name").resize_text()
	Utils.find_node("Characters").resize_all_sprite()
	
	var main_window = get_viewport().get_window()
	
	# Récupérer la hauteur actuelle de la fenêtre
	var window_height = main_window.size.y
	var window_width = main_window.size.x
	
	# Calculer la largeur minimale en fonction du ratio 4:3
	var min_width = int(window_height * (16.0 / 9.0))  # Ratio 4:3
	
	main_window.min_size = Vector2(min_width, main_window.min_size.y)
	var max_height = int(window_width * (9.0 / 16.0))  # Ratio 4:3
	main_window.max_size = Vector2(main_window.max_size.x, max_height)


func save_state():
	var sprites_locations = {}
	for character in Characters.characters:
		sprites_locations[character] = Characters.characters[character].sprite_location
	var state = {
		"characters": Characters.characters.duplicate(true),  # Duplique les personnages pour éviter les références partagées
		"sprites_locations": sprites_locations,
		"current_line_index": current_line_index,
		"modules": modules.duplicate(true),  # Duplique les modules pour éviter les références partagées
		"file_state": {
			"current_file_path": current_file_path,
			"file_position": file.get_position()
		},
		"dialogue_box_state": {
			"character": Utils.find_node("DialogueBox").current_talking,
			"text": Utils.find_node("DialogueBox").main_text
		}
	}
	history_stack.push_back(state)

func restore_state():
	if history_stack.size() > 1:
		var state = history_stack.pop_back()
		if state["dialogue_box_state"]["character"] == Utils.find_node("DialogueBox").current_talking:
			if state["dialogue_box_state"]["text"] == Utils.find_node("DialogueBox").main_text:
				state = history_stack.pop_back()
		for chara in Characters.characters:
			if chara not in state["characters"]:
				Characters.characters[chara].remove()
			else:
				Characters.characters[chara].sprite_location = state["sprites_locations"][chara]
				Characters.characters[chara].sprite.texture = Utils.get_image_texture(state["sprites_locations"][chara])
				Characters.characters[chara].resize_sprite()
		Characters.characters = state["characters"]
		current_line_index = state["current_line_index"]
		modules = state["modules"]
		current_file_path = state["file_state"]["current_file_path"]
		file.seek(state["file_state"]["file_position"])
		Utils.find_node("DialogueBox").change_talking(state["dialogue_box_state"]["character"])
		Utils.find_node("DialogueBox").update_text(state["dialogue_box_state"]["text"])
		Utils.find_node("MainText").modulate = "#ffffff"
		save_state()
