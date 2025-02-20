extends Node2D

var viewport

var characters = {}

func _ready() -> void:
	viewport = get_viewport()
	

# Classe personnalisée pour un character
class Character:
	var sprite: Sprite2D
	var position_x: float
	var direction: int  # 0 pour gauche, 1 pour droite
	var name: String
	var color: Color
	var viewport : Viewport
	var position : float

	func _init(pos_x: float, direction_char: int, char_name: String, char_color: Color, viewport_pass: Viewport, sprite_name: String):
		direction = direction_char
		name = char_name
		color = char_color
		viewport = viewport_pass
		position = pos_x

		# Créer un sprite pour le character
		sprite = Sprite2D.new()

		# Chemin du dossier du personnage
		var dir_path = "game/characters/" + name.to_lower() + "/"
		var dir = DirAccess.open(dir_path)

		if dir:
			dir.list_dir_begin()  # Commencer à parcourir les fichiers
			var file_name = dir.get_next()

			while file_name != "":
				if file_name.begins_with(sprite_name.to_lower()) and not dir.current_is_dir():
					var full_path = dir_path + file_name
					var texture = Utils.get_image_texture(full_path)
					
					if texture:
						print("using texture")
						sprite.texture = texture
					break  # On arrête la recherche après avoir trouvé la première correspondance
				file_name = dir.get_next()
		else:
			print("Erreur: Impossible d'ouvrir le dossier du personnage à l'emplacement : ", dir_path)

		# Si aucune texture n'a été chargée, afficher une erreur
		if not sprite.texture:
			print("Erreur: Aucune texture trouvée pour le sprite : ", sprite_name)
			return

		# Calculer la hauteur maximale autorisée (90% de la hauteur du viewport)
		var viewport_size = viewport.get_size()
		var max_height: float = viewport_size.y * 0.9
		var texture_height: float = sprite.texture.get_height()
		
		position_x = (viewport_size.x / 2) + ((viewport_size.x*0.6 / 2) * (pos_x / 50))

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
		sprite.texture = load("game/characters/"+name+"/"+sprite_name+".png")
	
	func set_z_index(new_z_index: int):
		sprite.z_index = new_z_index
		
	func resize_sprite():
		var viewport_size = viewport.get_size()
		var max_height: float = viewport_size.y * 0.9
		var texture_height: float = sprite.texture.get_height()
		
		var scale_factor: float = 1
		if texture_height > max_height:
			scale_factor = max_height / texture_height
			sprite.scale = Vector2(scale_factor, scale_factor)
		
		# put the sprite at the bottom
		sprite.position.y = viewport_size.y - ((sprite.texture.get_height() * scale_factor) / 2)

		# recalculate position x
		sprite.position.x = (viewport_size.x / 2) + ((viewport_size.x*0.6 / 2) * (position / 50))

		
	
# Fonction pour ajouter un character
func add_character(pos_x: float, dir: int, char_name: String, char_color: Color, sprite_name: String):
	var new_character = Character.new(pos_x, dir, char_name, char_color, viewport, sprite_name)
	add_child(new_character.sprite)
	characters[char_name] = new_character
	

func resize_all_sprite():
	for chara in characters:
		characters[chara].resize_sprite()
