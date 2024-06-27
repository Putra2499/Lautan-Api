extends CharacterBody2D

const SPEED = 300.0
var action = 0
var npc_near = false
var flag_near = false
var face = "D"
var inventory = [0,0]

signal Battle

func _physics_process(_delta):
	# Handle Action.
	if Input.is_action_just_pressed("ui_accept"):
		action = action + 1
		print("Action "+str(action))
		if npc_near:
			run_dialogue()
		elif flag_near:
			say("Bendera")
			emit_signal("Battle")
			position = Vector2.ZERO
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction:
		velocity = direction * SPEED
		if direction.x == 0:
			if direction.y > 0 :
				$Animation.play("Walk_Down")
				face = "D"
			elif direction.y < 0:
				$Animation.play("Walk_Up")
				face = "U"
		elif direction.y == 0:
			if direction.x > 0 :
				$Animation.play("Walk_Right")
				face = "R"
			elif direction.x < 0:
				$Animation.play("Walk_Left")
				face = "L"
	else:
		velocity = Vector2.ZERO
		match face:
			"D": $Animation.play("Idle_Front")
			"U": $Animation.play("Idle_Back")
			"R": $Animation.play("Idle_Right")
			"L": $Animation.play("Idle_Left")
	move_and_slide()

func say(dialog):
	$Control/Label.text = dialog
	$Control.show()
	$Control/SpeachTimer.start()

func run_dialogue():
	Dialogic.start("narasi1-3")

func pickup(item,amount):
	say("Mendapat "+str(amount)+" "+item_name(item))
	print("Saya mendapat "+str(amount)+" "+item_name(item))
	inventory[item] += amount
	print("Total "+item_name(item)+" = "+str(inventory[item]))

func item_name(item) -> String:
	match item:
		0 : return "ribu uang"
		1 : return "nasi"
		_ : return ""

func _on_speach_timer_timeout():
	$Control.hide()

