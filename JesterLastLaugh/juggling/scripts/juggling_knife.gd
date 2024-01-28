extends RigidBody2D

const jump_velocity = -100.0
var velocity = Vector2(0,0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D
@onready var parent = get_parent().get_parent()

func calculate_gravity(throw_force):
	return sqrt(gravity * throw_force)

func _ready():
	freeze = true

func throw(force):
	if parent:
			parent.add_gold(1 )
	sleeping = true
	var jump = -1 * calculate_gravity(force)
	apply_central_impulse(Vector2(0, jump));
	_animated_sprite.play("spin")

func _physics_process(delta):
	var collision_info = move_and_collide(Vector2(0,0))
	if collision_info:
		_animated_sprite.play("default")

func resume_knife():
	freeze = false
	apply_central_impulse(Vector2(0, -100));
	
func freeze_knife():
	freeze = true
