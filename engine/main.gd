extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.pass_main_scene($Scene)
	Core.init_modules()
	Core.load_file("game/story/test.mvn")
	Ui.load_texbox_texture("game/ui/textbar.png")
	start_game()

func start_game() -> void:
	print("sarting machin")
	Core.read_lines()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Core.read_lines()
