extends Control

func _on_new_pressed():
	get_tree().change_scene_to_file("res://Scenes/Worlds/map_pabrik.tscn")

func _on_load_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/progress_menu.tscn")
