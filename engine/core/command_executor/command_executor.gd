extends RefCounted

var current_talking_character: String = ""
var main = preload("res://engine/main.gd").new()

func execute_command(command: String, args: Array) -> void:
	match command:
		"bg":
			# Exemple : [bg forest]
			_change_background(args[0])
		
		"music":
			# Exemple : [music danger]
			_play_music(args[0])
		
		"choice":
			# Exemple : [choice "run", "hide", "fight"]
			_show_choices(args)

		"+":
			# add character to the scene
			_add_character(args[0])
		
		_: # if another command
			if command in main.characters:
				print(args, " on ", command)

func handle_dialogue(character: String, text: String) -> void:
	current_talking_character = character
	print(character + " : " + text)

func handle_narration(text: String) -> void:
	print("Narrateur : " + text)

func _change_background(image_name: String) -> void:
	print("Changement de fond : ", image_name)

func _play_music(track_name: String) -> void:
	print("Lecture musique : ", track_name)

func _show_choices(options: Array) -> void:
	print("Choix disponibles : ", options)

func _add_character(character_name: String) -> void:
	print("Ajout du personnage : ", character_name)
	main.characters[character_name] = character_name
	print(main.characters)
