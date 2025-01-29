extends Control

@export var target_lines: int = 4  # Nombre de lignes souhaité
@export var padding: float = 10.0  # Marge intérieure (en pixels)

func _ready():
	adjust_font_size()
	connect("resized", Callable(self, "adjust_font_size"))

func adjust_font_size():
	var label = $main_text   # Assure-toi que le chemin correspond à ton arbre de scène
	var font = label.get_theme_font("font")  # Récupère la police du Label
	# Calcule la hauteur disponible pour le texte
	var textbox_height = size.y - (2 * padding)
	var line_height = (textbox_height / target_lines) * 0.5
	
	# Ajuste la taille de la police
	if font is FontFile:
		font.fixed_size = int(line_height)
		label.add_theme_font_override("font", font)
		print(line_height)

func display_text(text : String):
	var label = $main_text
	print(text)
	#label.text = text

func change_talking(character):
	$character_name.text = character
