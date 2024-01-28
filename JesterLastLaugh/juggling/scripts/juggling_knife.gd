extends RigidBody2D

const jump_velocity = -30.0
var velocity = Vector2(0,0)
var burrow = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D
@onready var main_game = get_parent().get_parent()
@onready var main_scene = get_parent()
@export var sound: String = "res://juggling/assets/knife-swish.mp3"
var sound_stream

func calculate_gravity(throw_force):
	return sqrt(gravity * throw_force)

func _ready():
	sound_stream = load(sound)
	freeze = true

func throw(force):
	$AudioStreamPlayer2D.stream = sound_stream
	$AudioStreamPlayer2D.play()
	if main_game and !main_scene.finished:
		main_game.add_gold(1)
	sleeping = true
	var jump = -1 * calculate_gravity(force)
	apply_central_impulse(Vector2(0, jump));

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2(0,0))
	if collision_info:
		burrow_knife()

func resume_knife():
	freeze = false
	_animated_sprite.play("default")
	apply_central_impulse(Vector2(0, -35));
	
func freeze_knife():
	freeze = true
	$AnimatedSprite2D.stop()
	
func burrow_knife():
	if !burrow:
		get_parent().burrowed_knifes += 1
	burrow = true
	_animated_sprite.play("stuck")

func glow(value):
	if value:
		_animated_sprite.play("shining")
	else:
		_animated_sprite.play("default")

