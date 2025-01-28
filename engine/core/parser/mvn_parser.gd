extends RefCounted

var current_file_path: String
var file: FileAccess
var current_line_index: int = 0


func load_file(file_path: String) -> void:
	if not FileAccess.file_exists(file_path):
		push_error("Can't find .mvn : " + file_path)
		return
	
	current_file_path = file_path
	file = FileAccess.open(file_path, FileAccess.READ)
	current_line_index = 0


func read_next_line() -> String:
	if not file:
		push_error("no files open!")
		return ""
	
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		current_line_index += 1
		
		if line.is_empty() or line.begins_with("#"):
			continue
		
		return line
	
	return ""


func close_file() -> void:
	if file:
		file.close()
		file = null


func parse_line(line: String) -> Dictionary:
	var result = {}
	
	if line.begins_with("["):
		# Command (ex: [bg forest])
		result["type"] = "command"
		result["content"] = line.trim_prefix("[").trim_suffix("]")
	elif line.begins_with(">"):
		result["type"] = "character_dialogue"
		result["character"] = line.trim_prefix(">")
	elif line.begins_with("@"):
		result["type"] = "narration"
		result["text"] = line.trim_prefix("@")
	else:
		result["type"] = "text"
		result["text"] = line
	
	return result
