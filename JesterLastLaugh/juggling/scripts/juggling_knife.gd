extends RigidBody2D

const jump_velocity = -100.0
var velocity = Vector2(0,0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	velocity = Vector2(0, jump_velocity);

func throw(force):
	sleeping = true
	apply_central_impulse(Vector2(0, force));
	_animated_sprite.play("spin")
	

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2(0,0))
	if collision_info:
		_animated_sprite.play("default")
