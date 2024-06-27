@tool
extends StaticBody2D

enum Model{
	Indonesia_Flag,
	Japan_Flag,
	Dutch_Flag
}
@export var model : Model = Model.Indonesia_Flag
var attacker

var Sprites = [
	preload("res://Assets/Decorations/Flag(I).png"),
	preload("res://Assets/Decorations/Flag(J).png"),
	preload("res://Assets/Decorations/Flag(B).png")
]

signal flag_claim

func _ready():
	$Sprite2D.texture = Sprites[model]

func _on_area_2d_body_entered(body):
	if "Player" in str(body):
		body.flag_near = true
		Global.battle_pos = global_position
		$Control.show()

func _on_area_2d_body_exited(body):
	if "Player" in str(body):
		body.flag_near = false
		$Control.hide()

func selected(body):
	attacker = body
	if $Sprite2D.texture == Sprites[0]:
		return
	$Button.show()

func unselected():
	$Button.hide()

func _on_button_pressed():
	attacker.hide_range()
	attacker.end_turn()
	$AnimationPlayer.play("Klaim")
	$Button.hide()

func _on_animation_player_animation_finished(anim_name):
	$Sprite2D.texture = Sprites[0]
	print("Bendera Terklaim")
	emit_signal("flag_claim")
