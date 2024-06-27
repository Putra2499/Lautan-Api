extends Node2D

enum Mode {Explore,Battle}
@export var mode : Mode = Mode.Explore
var temp_pion = null

var pion_selected = false
var paused = false

@export var goal = 2
var progres = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		print("Paused")
		paused_menu()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$Mode_Battle/Target.position = $Map/TileMap.selected_tile

func paused_menu():
	if paused:
		$Mode_Explore/Player/PauseMenu.hide()
		Engine.time_scale = 1
	else :
		$Mode_Explore/Player/PauseMenu.show()
		Engine.time_scale = 0
	paused = !paused

func _on_item_picked_up(body,item,amount):
	body.pickup(item,amount)

func _on_button_pressed():
	if mode == Mode.Explore :
		mode = Mode.Battle
		$Control/Label.text = "Mode Battle"
		$Mode_Battle.show()
		$Mode_Battle.set_process(true)
		$Mode_Explore.hide()
		$Mode_Explore.set_process(false)
	else :
		mode = Mode.Explore
		$Control/Label.text = "Mode Explore" 
		$Mode_Explore.show()
		$Mode_Explore.set_process(true)
		$Mode_Battle.hide()
		$Mode_Battle.set_process(false)

func _on_target_object_here(obj):
	if "Pion" in str(obj):
		print("This is Pion")
		pion_selected = true
		obj.create_range()
		temp_pion = obj
	else :
		print(str(obj))
		pion_selected = false
	print("Pion Selected : "+ str(pion_selected))

func _on_target_exit():
	if temp_pion and not pion_selected:
		temp_pion.hide_range()

func _on_target_move(pos):
	if not temp_pion.move(pos) :
		pass

func _on_pion_attacked():
	$Mode_Battle/Target.position = temp_pion.position

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/TitleScreen.tscn")
	Engine.time_scale = 1

func _on_player_battle():
	$Mode_Explore.hide()
	$Mode_Battle.show()
	$Mode_Battle/Target.position = Global.battle_pos
	$Mode_Battle/Target/Camera2D.make_current()

func _on_flag_flag_claim():
	progres += 1
	if progres >= goal :
		game_clear()

func game_clear():
	$Mode_Battle/Target/Camera2D/Label.show()
