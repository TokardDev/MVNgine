extends RichTextLabel

var font_size

func _ready():
	var regular_font = Utils.get_font("game/ui/fonts/normal_font.ttf")
	var italic_font = Utils.get_font("game/ui/fonts/italic_font.ttf")
	var bold_font = Utils.get_font("game/ui/fonts/bold_font.ttf")
	var bold_italic_font = Utils.get_font("game/ui/fonts/italic_bold_font.ttf")
	add_theme_font_override("normal_font", regular_font)
	add_theme_font_override("italics_font", italic_font)
	add_theme_font_override("bold_font", bold_font)
	add_theme_font_override("bold_italics_font", bold_italic_font)
	resize_text()
	
func resize_text() -> void:
	var desired_lines = 4
	var available_height = size.y
	font_size = (available_height/desired_lines)*0.7
	add_theme_font_size_override("normal_font_size", font_size)
	add_theme_font_size_override("italics_font_size", font_size)
	add_theme_font_size_override("bold_italics_font_size", font_size)
	add_theme_font_size_override("bold_font_size", font_size)
	add_theme_font_size_override("mono_font_size", font_size)
