extends Node2D

var characters = {}

func execute_command(command: String, args: Array) -> void:
	match command:
		"bg":
			# Exemple : [bg forest]
			#$UI.change_background("res://game/story/"+args[0]+"png")
			print("changing background : ", args)
		
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
