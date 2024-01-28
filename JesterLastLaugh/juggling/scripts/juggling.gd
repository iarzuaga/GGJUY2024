extends Node
@onready var jester_knife = preload("res://juggling/models/juggling_knife.tscn")
var difficulty = 2
var burrowed_knifes = 0
var total_play_time: float = 20.0
var play_time: float = 0.0
var finished = false

func start():
	burrowed_knifes = 0
	get_child(1).paused = false
	for i in difficulty+1:
		var knife_node = get_child(3+i).resume_knife()


func stop():
	get_child(1).paused = true
	for i in difficulty+1:
		var knife_node = get_child(3+i).freeze_knife()

	
func set_difficulty(value):
	difficulty = value
	if value > 3:
		difficulty = 3
	for i in 3-difficulty:
		var knife_node = get_child(6-i)
		remove_child(knife_node)


func _process(delta):
	if !finished and burrowed_knifes == difficulty + 1 and play_time < total_play_time:
		finished = true
		get_parent().end_game(false)
		get_child(1).paused = true
		
	play_time += delta
	if !finished and play_time >= total_play_time and burrowed_knifes < difficulty + 1:
		finished = true
		get_parent().end_game(true)
		get_child(1).paused = true
		get_child(1).victory()
