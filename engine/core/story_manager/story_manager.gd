extends RefCounted

var parser = preload("res://engine/core/parser/mvn_parser.gd").new()
var command_executor = preload("res://engine/core/command_executor/command_executor.gd").new()

func start_story(file_path: String) -> void:
	parser.load_file(file_path)
	
	var line = parser.read_next_line()
	while not line.is_empty():
		var parsed = parser.parse_line(line)
		_process_parsed_line(parsed)
		line = parser.read_next_line() # change this
	
	parser.close_file()

func _process_parsed_line(parsed: Dictionary) -> void:
	match parsed["type"]:
		"command":
			var parts = parsed["content"].split(" ")
			var command = parts[0]
			var args = parts.slice(1) if parts.size() > 1 else []
			command_executor.execute_command(command, args)
		
		"character_dialogue":
			command_executor.current_talking_character = parsed["character"]
		
		"text":
			command_executor.handle_dialogue(command_executor.current_talking_character, parsed["text"])
		
		"narration":
			command_executor.handle_narration(parsed["text"])
