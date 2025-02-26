# --- do not touch this ---
extends Node

func get_commands() -> Dictionary:
	var commands : Dictionary
	
# --- edit under this line ---
	
	# how to add a command :
	# commands["<your name or symbol used in .mvn>"] = { "instance": self, "function": "<your function name>" }
	commands["+"] = { "instance": self, "function": "cmd_add" }
	commands["z"] = { "instance": self, "function": "cmd_change_index" }
	return commands

func cmd_add(char_name: String, sprite: String = char_name, position: String = "0"):
	if char_name not in Characters.characters:
		Characters.add_character(position.to_int(), 0, char_name, sprite)
	else:
		Characters.characters[char_name].change_sprite(sprite)

func cmd_change_index(char_name: String, z_index: String):
	var index = z_index.to_int()
	if char_name in Characters.characters:
		Characters.characters[char_name].set_z_index(index)
