extends Node2D

var viewport_size

func _ready() -> void:
	viewport_size = get_viewport().get_size()
	

# Classe personnalisée pour un character
class Character:
	var sprite: Sprite2D
	var position_x: float
	var direction: int  # 0 pour gauche, 1 pour droite
	var name: String
	var color: Color

	func _init(pos_x: float, direction_char: int, char_name: String, char_color: Color, viewport_size: Vector2, sprite_name: String):
		position_x = (viewport_size.x / 2) + ((viewport_size.x / 2) * (pos_x / 50))
		direction = direction_char
		name = char_name
		color = char_color

		# Créer un sprite pour le character
		sprite = Sprite2D.new()

		# Chemin du dossier du personnage
		var dir_path = "res://game/characters/" + name.to_lower() + "/"
		var dir = DirAccess.open(dir_path)

		if dir:
			dir.list_dir_begin()  # Commencer à parcourir les fichiers
			var file_name = dir.get_next()

			while file_name != "":
				if file_name.begins_with(sprite_name.to_lower()) and not dir.current_is_dir():
					var full_path = dir_path + file_name
					if ResourceLoader.exists(full_path):  # Vérifier si le fichier est une ressource valide
						sprite.texture = load(full_path)
						break  # On arrête la recherche après avoir trouvé la première correspondance
				file_name = dir.get_next()
		else:
			print("Erreur: Impossible d'ouvrir le dossier du personnage à l'emplacement : ", dir_path)

		# Si aucune texture n'a été chargée, afficher une erreur
		if not sprite.texture:
			print("Erreur: Aucune texture trouvée pour le sprite : ", sprite_name)
			return

		# Calculer la hauteur maximale autorisée (90% de la hauteur du viewport)
		var max_height: float = viewport_size.y * 0.9
		var texture_height: float = sprite.texture.get_height()

		# Si la hauteur du sprite dépasse la hauteur maximale, ajuster l'échelle
		var scale_factor: float = 1
		if texture_height > max_height:
			scale_factor = max_height / texture_height
			sprite.scale = Vector2(scale_factor, scale_factor)

		# Positionner le sprite
		sprite.position.x = position_x
		sprite.position.y = viewport_size.y - ((sprite.texture.get_height() * scale_factor) / 2)
		
	func move(new_x: float):
		position_x = new_x
		sprite.position.x = position_x

	func flip_direction():
		direction = 1 - direction  # Inverse la direction (0 -> 1, 1 -> 0)
		sprite.flip_h = direction == 1

	func set_color(new_color: Color):
		color = new_color
	
	func change_sprite(sprite_name: String):
		sprite.texture = load("res://game/characters/"+name+"/"+sprite_name+".png")

# Fonction pour ajouter un character
func add_character(pos_x: float, dir: int, char_name: String, char_color: Color, sprite_name: String = char_name):
	var new_character = Character.new(pos_x, dir, char_name, char_color, viewport_size, char_name)
	add_child(new_character.sprite)
