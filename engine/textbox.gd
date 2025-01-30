extends TextureRect

var current_talking: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_text(text: String, narr: bool = false) -> void:
	if narr:
		$Name.text = ""
	elif $Name.text == "":
		$Name.text = current_talking
	$MainText.text = text


func update_talking(character_name: String) -> void:
	current_talking = character_name
	$Name.text = character_name
