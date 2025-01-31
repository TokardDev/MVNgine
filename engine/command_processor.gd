extends Node2D

var characters = {}

func execute_command(command: String, args: Array) -> void:
	match command:
		"bg":
			# Exemple : [bg forest]
			#_change_background(args[0])
			print("changing background : ", args[0])
		
		"music":
			# Exemple : [music danger]
			print("playing music : ", args)
			#_play_music(args[0])
		
		"choice":
			# Exemple : [choice "run", "hide", "fight"]
			#_show_choices(args)
			print("displaying choice : ", args)

		"+":
			# Ajouter un personnage à la scène
			print("adding character : ", args)
			#_add_character(args[0])
		
		_: # Si une autre commande
			if command in characters:
				print(args, " on ", command)
