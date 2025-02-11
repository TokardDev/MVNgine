# --- do not touch this ---
extends Node

var scene : Node = null

func setup(scene_ref: Node):
	scene = scene_ref

func get_commands() -> Dictionary:
	var commands : Dictionary
	
# --- edit under this line ---

	# how to add a command :
	# commands["<your name or symbol used in .mvn>"] = { "instance": self, "function": "<your function name>" }
	commands["bg"] = { "instance": self, "function": "cmd_change_bg" }
	return commands

func cmd_change_bg(name: String):
	print("changing background")
	scene.get_node("UI").change_background(name)
