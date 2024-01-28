extends Node
@onready var jester_knife = preload("res://juggling/models/juggling_knife.tscn")
var difficulty = 1;
# Called when the node enters the scene tree for the first time.
func _ready():
	#pass
	for i in 3-difficulty:
		var knife_node = get_child(3+i)
		remove_child(knife_node)

func start():
	get_child(1).paused = false
	for i in 3-difficulty:
		var knife_node = get_child(3+i).resume_knife()
	pass

func stop():
	get_child(1).paused = true
	for i in 3-difficulty:
		var knife_node = get_child(3+i).freeze_knife()
	pass

