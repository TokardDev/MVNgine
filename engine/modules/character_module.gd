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
	commands["z"] = { "instance": self, "function": "cmd_change_index" }
	return commands

func cmd_add(char_name: String, sprite: String = char_name, position: String = "0"):
	if char_name not in scene.get_node("UI").get_node("characters").characters:
		scene.get_node("UI").get_node("characters").add_character(position.to_int(), 0, char_name, Color(1, 0, 0), sprite)
	else:
		scene.get_node("UI").get_node("characters").characters[char_name].change_sprite(sprite)

func cmd_change_index(char_name: String, z_index: String):
	print("chaning index")
	var index = z_index.to_int()
	if char_name in scene.get_node("UI").get_node("characters").characters:
		scene.get_node("UI").get_node("characters").characters[char_name].set_z_index(index)
		print("changing index")
