extends TextureRect

var current_talking: String

var character_colors: Dictionary

var main_text:
	get:
		return $MainText.text
	set(value):
		$MainText.text = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_text(text: String) -> void:
	main_text = text

func update_talking() -> void:
	$Name.text = current_talking


		

func change_talking(character_name: String) -> void:
	current_talking = character_name
	if character_colors.has(character_name):
		var color = Color(character_colors[character_name])
		$Name.modulate = color
	else:
		$Name.modulate = "#FFFFFF"
	$Name.text = current_talking


func load_character_colors(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		file.close()
		var json = JSON.new()  # Créer une instance de JSON
		json.parse(json_data)
		var result = json.data
		character_colors = result["characters"]
	else:
		push_error("File not found: ", file_path)
