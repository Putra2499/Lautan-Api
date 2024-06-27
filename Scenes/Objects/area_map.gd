extends Area2D

func _on_body_entered(body):
	if "Player" in str(body):
		get_tree().change_scene_to_file("res://Scenes/Menus/map.tscn")
	else :
		print(str(body))
