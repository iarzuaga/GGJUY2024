extends Node2D

@onready var timer:Timer=$Timer
@onready var packCircle:PackedScene = preload("res://Osu/Escenas/Circle.tscn")
@onready var Jester = $Jester
@onready var score = $ScoreCount
@onready var cordinate_top_left = $Cordinate_top_left
@onready var cordinate_top_right = $Cordinate_top_right
@onready var cordinate_botton_left = $Cordinate_botton_left
@onready var cordinate_botton_right = $Cordinate_botton_right
@onready var menu_song = $MenuSong

var _number_generator: RandomNumberGenerator
var viewport_size: Vector2
var playable_zone: Array[Vector2] = []
var actual_score: int
var difficulty_game: int
var time_spawn_circle : float
var time_kill_circle : float
var margin_one: int
var margin_two: int
var circle_total_win : int
var score_per_circle: int
var circle_number: int
var circle_died: int
var pocketed_circles: int

func start():
	timer.connect("timeout",_spawn_circles)
	timer.wait_time = time_spawn_circle
	timer.start()
	pass

func _ready():
	menu_song.play()
	playable_zone.append(cordinate_top_left.position)
	playable_zone.append(cordinate_top_right.position)
	playable_zone.append(cordinate_botton_left.position)
	playable_zone.append(cordinate_botton_right.position)
	Jester.get_node("AnimationPlayer").play("idle")
	_number_generator = RandomNumberGenerator.new()
	_number_generator.randomize()
	set_difficulty(1)
	
	add_child(score)
	score.score_per_circle = score_per_circle
	

func _spawn_circles():
	_control_win_defeat()
	var _random_num_x_position = _number_generator.randi_range(playable_zone[0].x,playable_zone[1].x)
	var _random_num_y_position = _number_generator.randi_range(playable_zone[0].y,playable_zone[2].y)
	var Circle: CharacterBody2D = packCircle.instantiate()
	Circle.position.x = _random_num_x_position
	Circle.position.y = _random_num_y_position
	Circle.time_kill_circle = time_kill_circle
	add_child(Circle)
	circle_number = circle_number + 1

func _score_count() -> int:
	return score._get_score()

func _add_gold():
	get_parent().add_gold(round(_score_count() / 2))

func set_difficulty(difficulty : int):
	difficulty_game = difficulty
	_set_difficulty_times()

func _set_difficulty_times():
	match (difficulty_game):
		0:
			time_spawn_circle = 2
			time_kill_circle = 1.3
			margin_one = 3
			margin_two = 6
			circle_total_win = 25
			score_per_circle = 2
		1:
			time_spawn_circle = 1.4
			time_kill_circle = 1
			margin_one = 5
			margin_two = 9
			circle_total_win = 5
			score_per_circle = 3
		2:
			time_spawn_circle =  0.8
			time_kill_circle = 0.5
			margin_one = 6
			margin_two = 9
			circle_total_win = 33
			score_per_circle = 5
		3:
			time_spawn_circle = 0.2
			time_kill_circle = 0.1
			margin_one = 4
			margin_two = 7
			circle_total_win = 40
			score_per_circle = 8

func _control_win_defeat():
	if circle_died <= circle_died and pocketed_circles + circle_died == circle_total_win:
		get_tree().paused = true
		get_parent().end_game(true)
	elif circle_died == margin_two + 1:
		get_tree().paused = true
		get_parent().end_game(false)

func _count_died_circles():
	circle_died = circle_died + 1

func _count_pocketed_circles():
	_add_gold()
	pocketed_circles = pocketed_circles + 1
