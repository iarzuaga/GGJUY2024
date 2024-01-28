extends Node2D

var total_play_time: float = 10.0
var play_time: float = 0.0
var mod_time: float = 0.0
var is_playing: bool = false
var hit: int = 0
var miss: int = 0
@onready var parent = get_parent()
@onready var laud = $Laud
@onready var timer: Timer = $Timer

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
		laud.stop()
		is_playing = false
		timer.timeout.disconnect(win_game)
		timer.timeout.disconnect(lose_game)
		
		if hit > miss:
			timer.connect("timeout", win_game)
		else:
			timer.connect("timeout", lose_game)
		timer.start(0)

func win_game():
	parent.end_game(true)

func lose_game():
	parent.end_game(false)

func start():
	play_time = 0
	is_playing = true
	laud.start()

func set_difficulty(level: int):
	match level:
		0: 
			laud.wait_between_shapes = 2.0
			laud.tempo = 70
			laud.set_speed(80)
		1:
			laud.wait_between_shapes = 2.0
			laud.tempo = 90
			laud.set_speed(80)
		2:
			laud.wait_between_shapes = 1.0
			laud.tempo = 120
			laud.set_speed(100)
		3:
			laud.wait_between_shapes = 1.0
			laud.tempo = 140
			laud.set_speed(100)
