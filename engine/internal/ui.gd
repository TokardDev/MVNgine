extends Node

var main_scene : Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func pass_main_scene(scene_node : Node2D):
	main_scene = scene_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_texbox_texture(box_texture : String) -> void:
	main_scene.get_node("UI").get_node("textbox").texture = Utils.get_image_texture(box_texture)
	"""
	$".".texture = load("res://game/ui/textbar.png")
	load_character_colors("res://game/characters/characters.json")
	$MainText.add_theme_font_override("italics_font", italic_font)
	$MainText.add_theme_font_override("normal_font", regular_font)
	"""
