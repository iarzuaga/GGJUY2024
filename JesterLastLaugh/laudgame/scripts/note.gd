extends Node2D

@export var speed = 100
@onready var sprite = $Sprite2D
var fail_tex = load("res://laudgame/note_fail.png")
var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.connect("timeout", _self_kill)

func _process(delta):
	translate(Vector2(0.0, 1.0) * speed * delta)

func fail():
	sprite.texture = fail_tex
	timer.start(0.2)

func _self_kill():
	get_parent().remove_child(self)
