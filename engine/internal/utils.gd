extends Node

var main_scene : Node2D = null

# Liste des extensions d'image supportées par Godot
const SUPPORTED_EXTENSIONS_IMAGES := ["png", "jpg", "jpeg", "bmp", "tga", "webp"]
const SUPPORTED_EXTENSIONS_FONTS := ["ttf", "otf"]

func pass_main_scene(scene_node : Node2D):
	main_scene = scene_node

func get_image_texture(path: String) -> ImageTexture:
	# Vérifie si l'extension du fichier est supportée
	var file_extension := path.get_extension().to_lower()
	if not file_extension in SUPPORTED_EXTENSIONS_IMAGES:
		print("Format d'image non supporté : ", file_extension)
		return null

	# Charge l'image
	var loaded_image := Image.new()
	var error := loaded_image.load(path)

	# Vérifie si le chargement a réussi
	if error != OK:
		print("Erreur lors du chargement de l'image : ", error)
		return null

	# Crée et retourne une ImageTexture à partir de l'image chargée
	return ImageTexture.create_from_image(loaded_image)
	

func get_font(path: String) -> Font:
	# Vérifie si l'extension du fichier est supportée
	var file_extension := path.get_extension().to_lower()
	if not file_extension in SUPPORTED_EXTENSIONS_FONTS:
		print("Format de police non supporté : ", file_extension)
		return null

	# Charge la police
	var font := FontFile.new()
	var error := font.load_dynamic_font(path)

	# Vérifie si le chargement a réussi
	if error != OK:
		print("Erreur lors du chargement de la police : ", error)
		return null

	# Retourne la police chargée
	return font
	
# get node from main_scene by name, independent of the node's parent
func find_node(node_name: String) -> Node:
	var root = get_tree().get_root()  # Obtient la racine de la scène actuelle
	return _find_node_recursive(root, node_name)
	
	
func _find_node_recursive(root: Node, node_name: String) -> Node:
	if root.name == node_name:
		return root
	
	for child in root.get_children():
		var result = _find_node_recursive(child, node_name)
		if result:
			return result
	
	return null
