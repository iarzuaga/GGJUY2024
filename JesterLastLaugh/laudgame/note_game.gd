extends Node2D

var total_play_time: float = 1.0
var play_time: float = 0.0
var mod_time: float = 0.0
var is_playing: bool = false
@onready var parent = get_parent()

func _ready():
	pass

func _process(delta):
	if not is_playing:
		return
	
	play_time += delta
	mod_time += delta
	
	if mod_time >= 3.0 and play_time < total_play_time:
		mod_time = 0
		if parent:
			parent.add_gold(5)
	
	if play_time >= total_play_time:
		$Laud.stop()
		is_playing = false
		get_parent().end_game(true)

func start():
	play_time = 0
	is_playing = true
	$Laud.start()
