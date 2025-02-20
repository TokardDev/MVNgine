extends RichTextLabel

func _ready():
	resize_text()

func resize_text() -> void:
	var font_size = $"../MainText".font_size*1.5
	add_theme_font_size_override("normal_font_size", font_size)
