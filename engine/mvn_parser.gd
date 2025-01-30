extends RefCounted

var current_file_path: String
var file: FileAccess
var current_line_index: int = 0

# Charger le fichier
func load_file(file_path: String) -> void:
	if not FileAccess.file_exists(file_path):
		push_error("Can't find .mvn : " + file_path)
		return
	
	current_file_path = file_path
	file = FileAccess.open(file_path, FileAccess.READ)
	current_line_index = 0

# Lire la prochaine ligne qui n'est pas vide ou un commentaire
func read_next_line() -> String:
	if not file:
		push_error("No files open!")
		return ""
	
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		current_line_index += 1
		
		if line.is_empty() or line.begins_with("#"):
			continue
		
		return line
	
	return ""  # Retourne une chaîne vide si tout est lu

# Fermer le fichier
func close_file() -> void:
	if file:
		file.close()
		file = null

# Analyser une ligne de texte et renvoyer un dictionnaire
func parse_line(line: String) -> Dictionary:
	var result = {}
	
	if line.begins_with("["):
		# Commande (ex: [bg forest])
		result["type"] = "command"
		result["content"] = line.trim_prefix("[").trim_suffix("]")
	elif line.begins_with(">"):
		# Dialogue d'un personnage
		result["type"] = "character_dialogue"
		result["character"] = line.trim_prefix(">")
	elif line.begins_with("@"):
		# Narration
		result["type"] = "narration"
		result["text"] = line.trim_prefix("@")
	else:
		# Texte normal
		result["type"] = "text"
		result["text"] = line
	
	return result
