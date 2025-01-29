extends CanvasLayer

func _ready():
	$Control/main_text.text = "hello world"

func update_text(text):
	$Control/main_text.text = "text"
