extends Node2D

var mvn_parser_script = load("res://engine/mvn_parser.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.pass_main_scene($Scene)
	Core.init_modules()
	Core.load_file("res://game/story/test.mvn")
	Ui.pass_main_scene($Scene)
	Ui.load_texbox_texture("res://game/ui/textbar.png")
	Core.read_lines()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Core.read_lines()
