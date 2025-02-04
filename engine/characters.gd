extends Node2D

func _ready():
	var viewport_size = get_viewport().get_size()

	add_character(-15, 1, "Copper", Color(1, 0, 0), viewport_size)
	

# Classe personnalisée pour un character
class Character:
	var sprite: Sprite2D
	var position_x: float
	var direction: int  # 0 pour gauche, 1 pour droite
	var name: String
	var color: Color

	func _init(pos_x: float, dir: int, char_name: String, char_color: Color, viewport_size, sprite_name: String = char_name):
		position_x = (viewport_size.x / 2) + ((viewport_size.x / 2) * (pos_x / 50))
		direction = dir
		name = char_name
		color = char_color
		# Créer un sprite pour le character
		sprite = Sprite2D.new()
		sprite.texture = load("res://game/characters/"+name.to_lower()+"/"+sprite_name.to_lower()+".png")
		
		# Calculer la hauteur maximale autorisée (90% de la hauteur du viewport)
		var max_height: float = viewport_size.y * 0.9

	# Obtenir la hauteur d'origine de la texture
		var texture_height: float = sprite.texture.get_height()

	# Si la hauteur du sprite dépasse la hauteur maximale, ajuster l'échelle
		var scale_factor: float = 1
		if texture_height > max_height:
			scale_factor = max_height / texture_height
			sprite.scale = Vector2(scale_factor, scale_factor)
			sprite.position.x = position_x
		sprite.position.y = viewport_size.y - ((sprite.texture.get_height()*scale_factor)/2)
		
		
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
func add_character(pos_x: float, dir: int, char_name: String, char_color: Color, viewport_size):
	var new_character = Character.new(pos_x, dir, char_name, char_color, viewport_size)
	add_child(new_character.sprite)
