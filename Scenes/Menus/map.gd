extends Node2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Worlds/map_pabrik.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Worlds/map_kantor_ka.tscn")

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/Worlds/map_gedung_denis.tscn")
