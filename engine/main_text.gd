extends RichTextLabel

func _ready():
	resize_text()
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_resized"))
	
func resize_text() -> void:
	var desired_lines = 4
	var available_height = size.y
	var font_size = (available_height/desired_lines)*0.7
	add_theme_font_size_override("normal_font_size", font_size)
	add_theme_font_size_override("italics_font_size", font_size)
	add_theme_font_size_override("bold_italics_font_size", font_size)
	add_theme_font_size_override("bold_font_size", font_size)
	add_theme_font_size_override("mono_font_size", font_size)

func _on_viewport_resized():
	resize_text()
