extends Control

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/TitleScreen.tscn")

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/Worlds/map_pabrik.tscn")
