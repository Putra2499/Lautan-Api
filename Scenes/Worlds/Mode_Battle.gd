extends Node2D

var turn = true

func _ready():
	check_turn()

#cek giliran selesai
func check_turn():
	for i in self.get_children():
		print(i)
