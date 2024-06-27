@tool
extends StaticBody2D

enum Model{
	Tree1,
	Tree2
}
@export var model : Model = Model.Tree1

var Sprites = [
	preload("res://Assets/Decorations/Tree(1).png"),
	preload("res://Assets/Decorations/Tree(2).png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = Sprites[model]
