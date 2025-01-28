extends Node

var current_talking_character = ""

func _ready():
	var parser = preload("res://engine/core/parser/mvn_parser.gd").new()
	parser.load_file("res://game/story/test.mvn")
	
	var line = parser.read_next_line()
	while not line.is_empty():
		var parsed = parser.parse_line(line)
		match parsed["type"]:
			"command":
				print("["+parsed["content"]+"]")

			"character_dialogue":
				current_talking_character = parsed["character"]
			
			"narration":
				print(parsed["text"])
			
			"text":
				print(current_talking_character + " : " + parsed["text"])
		
		line = parser.read_next_line()
	
	parser.close_file()
