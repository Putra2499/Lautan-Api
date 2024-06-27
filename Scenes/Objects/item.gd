@tool
extends StaticBody2D

enum Item {Uang,Nasi}
@export var item : Item = Item.Uang
@export var amount : int = 1
signal PickedUp(body,item,amount)

func _on_area_2d_body_entered(body):
	if "Player" in str(body):
		PickedUp.emit(body,item,amount)
		queue_free()
		
