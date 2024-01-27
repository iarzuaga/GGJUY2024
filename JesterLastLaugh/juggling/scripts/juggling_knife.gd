extends Area2D

const jump_velocity = -800.0
var velocity = Vector2(0,0)
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	speed = Vector2(0, jump_velocity);

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

func _throw(force):
	speed = Vector2(0, jump_velocity);
