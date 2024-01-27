extends Node2D

var play_time = 0
var mod_time = 0
var gold_func = null

# Called when the node enters the scene tree for the first time.
func _process(delta):
	play_time += delta
	mod_time += delta
	
	if fmod(mod_time, 2.0) == 0:
		mod_time = 0
		
		if gold_func:
			gold_func.call_func(5)

func set_gold_func(f):
	gold_func = f
	print(typeof(f))
