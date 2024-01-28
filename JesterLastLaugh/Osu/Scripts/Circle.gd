extends CharacterBody2D
@onready var animationIdle = $JesterIdle
@onready var measureTime = $Timer
@onready var audioStream = $ClickCircleSong
var score: Node
var wait_time_circle_kill : float
var time_kill_circle : float
var circle_died : int
var margin_one : int
var margin_two : int
var circle_total_win : int
var spawned: int

func _ready():
	score = get_parent().get_node("ScoreCount")
	measureTime.connect("timeout", _pre_eliminate_circle)
	measureTime.wait_time = time_kill_circle
	measureTime.start()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if position.distance_to(get_parent().get_node("Camera2D").get_global_mouse_position()) < 11:
			audioStream.play()
			animationIdle.play("Circle_Right")

func _change_animation():
	animationIdle.play("dab")

func _on_animated_sprite_2d_animation_finished():
	score._score_plus()
	get_parent()._count_pocketed_circles()
	_eliminate_circle()

func _pre_eliminate_circle():
	get_parent()._count_died_circles()
	_eliminate_circle()

func _eliminate_circle():
	queue_free()
