extends Area2D

@export var NextSceneName : String


func _on_area_body_entered(body):
	if body.name == "player":
		var nextScene = load("res://Scenes/" + NextSceneName + ".tscn")
		get_tree().change_scene_to_packed(nextScene)
		
