extends Node2D

var mvn_parser_script = load("res://engine/mvn_parser.gd")
var file_reader : RefCounted
var cmd_executor_script = load("res://engine/command_processor.gd")
var cmd_executor : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	file_reader = mvn_parser_script.new()
	cmd_executor = cmd_executor_script.new()
	file_reader.load_file("res://game/story/test.mvn")
	read_lines()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func read_lines() -> void:
	var line = file_reader.read_next_line()
	var parsed = file_reader.parse_line(line)
	if parsed["type"] != "text" and parsed["type"] != "narration":
		_process_parsed_line(parsed)
		read_lines()
	else:
		_process_parsed_line(parsed)

func _process_parsed_line(parsed: Dictionary) -> void:
	match parsed["type"]:
		"command":
			var parts = parsed["content"].split(" ")
			var command = parts[0]
			var args = parts.slice(1) if parts.size() > 1 else []
			cmd_executor.execute_command(command, args)
		
		"character_dialogue":
			$Scene/UI/textbox.update_talking(parsed["character"])
		
		"text":
			$Scene/UI/textbox.update_text(parsed["text"])
		
		"narration":
			$Scene/UI/textbox.update_text(parsed["text"], true)
			

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			read_lines()
