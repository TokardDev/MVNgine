extends Node

func change_background(background_name: String) -> void:
	var dir = DirAccess.open("game/backgrounds/")
	
	if dir:
		dir.list_dir_begin()  # Commencer à parcourir les fichiers
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.begins_with(background_name) and not dir.current_is_dir():
				var full_path = "game/backgrounds/" + file_name
				Utils.find_node("Background").texture = Utils.get_image_texture(full_path)
				return  # On arrête la recherche après avoir trouvé la première correspondance
			file_name = dir.get_next()
	else:
		print("Erreur: Impossible d'ouvrir le dossier des arrière-plans.")
