extends Node2D

@onready var timer:Timer=$Timer
@onready var packCircle:PackedScene = preload("res://Osu/Escenas/Circle.tscn")
@onready var Jester = $Jester
@onready var Score = $ScoreCount
@onready var cordinate_top_left = $Cordinate_top_left
@onready var cordinate_top_right = $Cordinate_top_right
@onready var cordinate_botton_left = $Cordinate_botton_left
@onready var cordinate_botton_right = $Cordinate_botton_right

var _number_generator: RandomNumberGenerator
var viewport_size: Vector2
var playable_zone: Array[Vector2] = []

func _ready():
	playable_zone.append(cordinate_top_left.position)
	playable_zone.append(cordinate_top_right.position)
	playable_zone.append(cordinate_botton_left.position)
	playable_zone.append(cordinate_botton_right.position)
	
	_number_generator = RandomNumberGenerator.new()
	_number_generator.randomize()
	timer.connect("timeout",_spawn_circles)
	timer.wait_time = 0.5
	timer.start()

func _spawn_circles():
	var _random_num_x_position = _number_generator.randi_range(playable_zone[0].x,playable_zone[1].x)
	var _random_num_y_position = _number_generator.randi_range(playable_zone[0].y,playable_zone[2].y)
	var Circle: CharacterBody2D = packCircle.instantiate()
	Circle.position.x = _random_num_x_position
	Circle.position.y = _random_num_y_position
	add_child(Circle)

func _score_count():
	var actual_score: int = Score._get_score()
