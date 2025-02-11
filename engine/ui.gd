extends CanvasLayer


func change_background(name: String) -> void:
	var dir = DirAccess.open("res://game/backgrounds/")
	
	if dir:
		dir.list_dir_begin()  # Commencer à parcourir les fichiers
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.begins_with(name) and not dir.current_is_dir():
				var full_path = "res://game/backgrounds/" + file_name
				if ResourceLoader.exists(full_path):  # Vérifier si le fichier est une ressource valide
					$Background.texture = load(full_path)
					return  # On arrête la recherche après avoir trouvé la première correspondance
			file_name = dir.get_next()
	else:
		print("Erreur: Impossible d'ouvrir le dossier des arrière-plans.")
