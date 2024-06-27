extends Node

var battle_pos = Vector2.ZERO
enum Chapters {
	ch0_1,
	ch0_2,
	ch1_1,
	ch1_2,
	ch2_1,
	ch2_2,
	ch3_1,
	ch3_2,
	ch4_1,
	ch4_2
}
var item : Chapters = Chapters.ch0_1
var new_battle = false
var pions_position
