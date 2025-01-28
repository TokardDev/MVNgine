extends Node

var characters = {}

func _ready():
	var story_manager = preload("res://engine/core/story_manager/story_manager.gd").new()
	story_manager.start_story("res://game/story/test.mvn")
