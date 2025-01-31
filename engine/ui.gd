extends CanvasLayer


func change_background(path: String) -> void:
	$Background.texture = load(path)
