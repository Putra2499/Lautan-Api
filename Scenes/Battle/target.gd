extends Node2D

signal object_here(obj)
signal exit()
signal move(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("float")
		

func _on_area_2d_body_entered(body):
	if "Pion" in str(body):
		object_here.emit(body)

func show_button():
	$Button.show()

func _on_target_area_area_entered(area):
	if "Range" in str(area):
		call_deferred("show_button")
	else :
		emit_signal("exit")


func _on_target_area_area_exited(area):
	if "Range" in str(area):
		$Button.hide()

func _on_button_pressed():
	move.emit(global_position)
