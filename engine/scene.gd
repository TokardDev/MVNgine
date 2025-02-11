extends Node2D

var characters = {}

var modules = {}

func _ready():
	load_modules("res://game/modules")
	load_modules("res://engine/modules")

func load_modules(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".gd") and not dir.current_is_dir():
				var module_script = load(path + "/" + file_name)
				if module_script:
					var module_instance = module_script.new()
					modules.merge(module_instance.get_commands())
					add_child(module_instance)
					module_instance.setup($".")
			file_name = dir.get_next()
			


func execute_command(command: String, args: Array):
	if command in modules:
		var module_instance = modules[command]["instance"]
		var method_name = modules[command]["function"]
		if module_instance.has_method(method_name):
			var callable = Callable(module_instance, method_name)
			callable.callv(args)
		else:
			print("Command not found: ", command)
	else:
		print("Unknown command: ", command)
