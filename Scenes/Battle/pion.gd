@tool
extends StaticBody2D

enum Char {Player, Indo_Soilder, Japan_Soilder, Duch_Soilder}
@export var character : Char = Char.Player
enum Team {Ally, MC, Enemy}
@export var team : Team = Team.Ally
var num = 1
@export var speed = 3

var tile_wide = 50
var tile_high = 30

var range_area = preload("res://Scenes/Battle/range_area.tscn")

@export var maxhp = 100
var hp = maxhp
@export var atk = 30

var nearby = []
var nearest = $".".position

var turn = true
var attacker

signal Attacked()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_mark()
	$Mark/Target.hide()
	$UI/HP.text = str(hp)

func set_mark():
	$Mark/AnimationPlayer.play("Floating_Mark")
	$Mark/Point.frame = team
	match character:
		0 : $AnimatedSprite2D.play("MC")
		1 : $AnimatedSprite2D.play("TRI")
		2 : $AnimatedSprite2D.play("Japan")
		3 : $AnimatedSprite2D.play("NICA")
		
	if team == Team.Enemy:
		$Mark/Target.modulate = Color.RED
	else :
		$Mark/Target.modulate = Color.AQUA

func end_turn():
	turn = false

func act():
	if turn:
		if team == Team.Enemy :
			pass
		else :
			create_range()

func create_range():
	if turn:
		if team == Team.Enemy :
			pass
		else: 
			for x in speed:
				for y in speed:
					if x == y and x == int((speed-1)/2):
						pass
					else:
						inst(Vector2(tile_wide*(x-y),tile_high*(x+y-speed+1)))

func inst(pos):
	var instance = range_area.instantiate()
	instance.position = pos
	instance.attacker = $"."
	$Range.add_child(instance)

func hide_range():
	if $Range.get_child_count() > 0:
		var children = $Range.get_children()
		for c in children:
			$Range.remove_child(c)
			c.queue_free()
	$Mark/Target.hide()

func move(pos):
	nearby.clear()
	print_nearby()
	position = pos
	hide_range()

func print_nearby():
	print("->"+str($".".name))
	for i in nearby.size():
		if nearby[i].team == 2 :
			print("Enemy "+nearby[i].name)
		else :
			print("Ally "+nearby[i].name)
			nearest.x = max(float(nearby[i].position.x),float(nearest.x))
			nearest.y = max(float(nearby[i].position.y),float(nearest.y))
	print("---"+str(nearest))

func targeted(body):
	print(str(name)+" Targeted by "+str(body))
	attacker = body
	$UI/Atk_Button.show()

func untarget():
	print(str(name)+" Untarget")
	$UI/Atk_Button.hide()

func dead():
	$AnimatedSprite2D.modulate = Color.BLACK
	$UI/HP.text = "Kalah"
	$DeadTimer.start()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			#print(event.as_text())
			if event.pressed:
				#print("Left button was clicked at ", event.position)
				$Mark/Target.hide()

func _on_area_2d_mouse_entered():
	$Mark/Point.show()
	$UI/HP.show()
	$UI/HP_Bar.show()

func _on_area_2d_mouse_exited():
	$Mark/Point.hide()
	$UI/HP.hide()
	$UI/HP_Bar.hide()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			#print(event.as_text())
			if event.pressed:
				#print("Left button was clicked at ", event.position)
				$Mark/Target.show()

func _on_atk_button_pressed():
	emit_signal("Attacked")
	$AnimationPlayer.play("Attacked")
	print(str($".".name)+" Attacked")
	$UI/HP.show()
	$UI/HP_Bar.show()
	hp -= attacker.atk
	attacker.hide_range()
	attacker.end_turn()
	$UI/HP.text = str(hp)
	if hp <= 0:
		hp = 0
		dead()
	$UI/HP_Bar/HP.size.x = 38*hp/maxhp
	print("HP Bar : "+str($UI/HP_Bar/HP.size.x))

func _on_dead_timer_timeout():
	queue_free()

func _on_detec_area_body_entered(body):
	if str($".") in str(body):
		pass 
	elif "Pion" in body.name:
		#print(str($".".name)+" Near "+str(body.name))
		nearby.append(body)
		print_nearby()
