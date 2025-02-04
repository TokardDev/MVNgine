extends Node2D

func _ready():
	var amicus = preload("res://game/characters/amicus/ami.png")
	var neferu = preload("res://game/characters/neferu/nef-f-cross.png")
	var viewport_size = get_viewport().get_size()

	add_character(100, 1, "Amicus", Color(1, 0, 0), amicus, viewport_size)
	add_character(200, 0, "Neferu", Color(0, 0, 1), neferu, viewport_size)
	

# Classe personnalisée pour un character
class Character:
	var sprite: Sprite2D
	var position_x: float
	var direction: int  # 0 pour gauche, 1 pour droite
	var name: String
	var color: Color

	func _init(pos_x: float, dir: int, char_name: String, char_color: Color, texture: Texture2D, viewport_size):
		position_x = pos_x
		direction = dir
		name = char_name
		color = char_color
		# Créer un sprite pour le character
		sprite = Sprite2D.new()
		sprite.position.x = position_x
		sprite.texture = texture
		print(viewport_size.y)
		sprite.position.y = viewport_size.y - (sprite.texture.get_height()/2)
		
	func move(new_x: float):
		position_x = new_x
		sprite.position.x = position_x

	func flip_direction():
		direction = 1 - direction  # Inverse la direction (0 -> 1, 1 -> 0)
		sprite.flip_h = direction == 1

	func set_color(new_color: Color):
		color = new_color
		sprite.modulate = new_color

# Fonction pour ajouter un character
func add_character(pos_x: float, dir: int, char_name: String, char_color: Color, texture: Texture2D, viewport_size):
	var new_character = Character.new(pos_x, dir, char_name, char_color, texture, viewport_size)
	add_child(new_character.sprite)
