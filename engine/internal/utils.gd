extends Node


func get_image_texture(path: String) -> ImageTexture:	
		var loaded_image := Image.new()
		var error := loaded_image.load(path)
		
		if error != OK:
			return null

		return ImageTexture.create_from_image(loaded_image)
