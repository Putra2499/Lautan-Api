extends Node2D

var selected = false
var attacker

func _on_area_2d_mouse_entered():
	if not selected:
		$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()

func _on_area_2d_area_entered(area):
	if "Target" in str(area):
		selected = true
		$Hover.hide()
	if "Range" in str(area):
		queue_free()

func _on_area_2d_area_exited(area):
	if "Target" in str(area):
		selected = false

func _on_range_area_body_entered(body):
	#print("Range : "+str(body)+" at "+ str(global_position))
	if "Pion" in str(body):
		if body.team == 2 :
			modulate = Color.RED
			body.targeted(attacker)
		else:
			queue_free()
	elif "Flag" in str(body):
		modulate = Color.BLUE
		body.selected(attacker)
	else :
		queue_free()

func _on_range_area_body_exited(body):
	if "Pion" in str(body):
		body.untarget()
	elif "Flag" in str(body):
		body.unselected()
