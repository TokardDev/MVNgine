extends Node

var viewport

var characters = {}

func _ready() -> void:
	viewport = get_viewport()
	
# Classe personnalisée pour un character
class Character:
	var sprite: Sprite2D
	var position_x: float
	var direction: int  # 0 pour gauche, 1 pour droite
	var name: String
	var color: Color
	var viewport : Viewport
	var position : float
	var sprite_location : String

	func _init(pos_x: float, direction_char: int, char_name: String, char_color: Color, viewport_pass: Viewport, sprite_name: String):
		direction = direction_char
		name = char_name
		color = char_color
		viewport = viewport_pass
		position = pos_x

		# Créer un sprite pour le character
		sprite = Sprite2D.new()
		sprite.name = name

		# Chemin du dossier du personnage
		var dir_path = "game/characters/" + name.to_lower() + "/"
		var dir = DirAccess.open(dir_path)

		if dir:
			dir.list_dir_begin()  # Commencer à parcourir les fichiers
			var file_name = dir.get_next()

			while file_name != "":
				if file_name.begins_with(sprite_name.to_lower()) and not dir.current_is_dir():
					var full_path = dir_path + file_name
					sprite_location = full_path
					var texture = Utils.get_image_texture(full_path)
					
					if texture:
						sprite.texture = texture
					break  # On arrête la recherche après avoir trouvé la première correspondance
				file_name = dir.get_next()
		else:
			print("Erreur: Impossible d'ouvrir le dossier du personnage à l'emplacement : ", dir_path)

		# Si aucune texture n'a été chargée, afficher une erreur
		if not sprite.texture:
			print("Erreur: Aucune texture trouvée pour le sprite : ", sprite_name)
			return

		# Calculer la hauteur maximale autorisée (90% de la hauteur du viewport)
		var viewport_size = viewport.get_size()
		var max_height: float = viewport_size.y * 0.9
		var texture_height: float = sprite.texture.get_height()
		
		position_x = (viewport_size.x / 2) + ((viewport_size.x*0.6 / 2) * (pos_x / 50))

		# Si la hauteur du sprite dépasse la hauteur maximale, ajuster l'échelle
		var scale_factor: float = 1
		if texture_height > max_height:
			scale_factor = max_height / texture_height
			sprite.scale = Vector2(scale_factor, scale_factor)

		# Positionner le sprite
		sprite.position.x = position_x
		sprite.position.y = viewport_size.y - ((sprite.texture.get_height() * scale_factor) / 2)
		
	func move(new_x: float):
		position_x = new_x
		sprite.position.x = position_x

	func flip_direction():
		direction = 1 - direction  # Inverse la direction (0 -> 1, 1 -> 0)
		sprite.flip_h = direction == 1

	func set_color(new_color: Color):
		color = new_color

	func change_sprite(sprite_name: String):
		sprite_location = "game/characters/"+name+"/"+sprite_name+".png"
		sprite.texture = Utils.get_image_texture(sprite_location)
		resize_sprite()

	func set_z_index(new_z_index: int):
		sprite.z_index = new_z_index
		
	func resize_sprite():
		var viewport_size = viewport.get_size()
		var max_height: float = viewport_size.y * 0.9
		var texture_height: float = sprite.texture.get_height()
		
		var scale_factor: float = 1
		if texture_height > max_height:
			scale_factor = max_height / texture_height
			sprite.scale = Vector2(scale_factor, scale_factor)
		
		# put the sprite at the bottom
		sprite.position.y = viewport_size.y - ((sprite.texture.get_height() * scale_factor) / 2)

		# recalculate position x
		sprite.position.x = (viewport_size.x / 2) + ((viewport_size.x*0.6 / 2) * (position / 50))

	func remove():
		sprite.queue_free()
		

# Fonction pour ajouter un character
func add_character(pos_x: float, dir: int, char_name: String, sprite_name: String):
	var char_color = get_char_color(char_name)
	if char_color == "":
		char_color = "#ffffff"
	var new_character = Character.new(pos_x, dir, char_name, char_color, viewport, sprite_name)
	Utils.find_node("Characters").add_child(new_character.sprite)
	characters[char_name] = new_character
	
func remove_character(char_name: String):
	if char_name in characters:
		characters[char_name].remove()
		characters.erase(char_name)

func resize_all_sprite():
	for chara in characters:
		characters[chara].resize_sprite()


func get_char_color(character_name: String) -> String:
	var file_path = "game/characters/characters.json"
	if not FileAccess.file_exists(file_path):
		push_error("Can't find character json !")
		return ""

	var file = FileAccess.open(file_path, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()

	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		push_error("Failed to parse JSON")
		return ""

	var data = json.get_data()
	if not data.has("characters"):
		push_error("Invalid JSON structure")
		return ""

	var characters = {}
	for key in data["characters"].keys():
		characters[key.to_lower()] = data["characters"][key]

	var lower_name = character_name.to_lower()
	if lower_name in characters:
		return characters[lower_name]

	push_error("Character not found in JSON: " + character_name)
	return ""
