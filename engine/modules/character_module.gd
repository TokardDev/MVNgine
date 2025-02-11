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
	commands["+"] = { "instance": self, "function": "cmd_add" }
	return commands

func cmd_add(name: String, sprite: String = "", position: String = "0"):
	print(position)
	scene.get_node("UI").get_node("characters").add_character(position.to_int(), 0, name, Color(1, 0, 0))
