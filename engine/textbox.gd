extends TextureRect

var current_talking: String

var regular_font = load("res://game/ui/fonts/normal_font.ttf")

var italic_font = load("res://game/ui/fonts/italic_font.ttf")

var bold_font = load("res://game/ui/fonts/bold_font.ttf")

var bold_italic_font = load("res://game/ui/fonts/italic_bold_font.ttf")

var character_colors: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".texture = load("res://game/ui/textbar.png")
	load_character_colors("res://game/characters/characters.json")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_text(text: String, narr: bool = false) -> void:
	if narr:
		$Name.text = ""
		$MainText.add_theme_font_override("normal_font", italic_font)
	elif $Name.text == "":
		update_talking(current_talking)
		$MainText.add_theme_font_override("normal_font", regular_font)
	$MainText.text = text


func update_talking(character_name: String) -> void:
	current_talking = character_name
	$MainText.add_theme_font_override("normal_font", regular_font)
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
