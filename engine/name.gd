extends RichTextLabel

func _ready():
	resize_text()
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_resized"))

func resize_text() -> void:
	add_theme_font_size_override("normal_font_size", int(size.y*0.75))

func _on_viewport_resized():
	resize_text()
