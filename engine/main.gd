extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utils.pass_main_scene($Scene)
	Core.init_modules()
	Core.load_file("game/story/planes.mvn")
	Ui.load_texbox_texture("game/ui/textbar.png")
	start_game()

func start_game() -> void:
	Core.read_lines()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				Core.read_lines()
			MOUSE_BUTTON_WHEEL_DOWN, MOUSE_BUTTON_WHEEL_UP:
				if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					Core.read_lines(true)
				else:
					Core.restore_state()
			MOUSE_BUTTON_RIGHT:
				print("display menu")
