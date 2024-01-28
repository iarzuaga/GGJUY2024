extends Node2D

var total_play_time: float = 30.0
var play_time: float = 0.0
var mod_time: float = 0.0
@onready var parent = get_parent()

func _ready():
	pass

func _process(delta):
	play_time += delta
	mod_time += delta
	
	if mod_time >= 3.0 and play_time < total_play_time:
		mod_time = 0
		if parent:
			parent.add_gold(5)
	
	if play_time >= total_play_time:
		$Laud.stop()
		get_parent().end_game(true)

func start():
	play_time = 0
	$Laud.start()
