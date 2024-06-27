extends StaticBody2D

func _on_area_2d_body_entered(body):
	if "Player" in str(body):
		body.npc_near = true
		$Control.show()

func _on_area_2d_body_exited(body):
	if "Player" in str(body):
		body.npc_near = false
		$Control.hide()
