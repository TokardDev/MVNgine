# --- do not touch this ---
extends Node

func get_commands() -> Dictionary:
	var commands : Dictionary
	
# --- edit under this line ---

	# how to add a command :
	# commands["<your name or symbol used in .mvn>"] = { "instance": self, "function": "<your function name>" }
	commands["bg"] = { "instance": self, "function": "cmd_change_bg" }
	return commands

func cmd_change_bg(background_name: String):
	Utils.find_node("Scene").change_background(background_name)
