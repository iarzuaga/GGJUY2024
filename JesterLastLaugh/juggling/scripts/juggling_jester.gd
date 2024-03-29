extends CharacterBody2D


@export var final_speed = 250
var speed = 30
var paused = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var inside_body = false
var knife = null
var knife_force = 0

func _physics_process(delta):
	# Add the gravity.
	if paused : return
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	var arrow_direction = Input.get_axis("ui_left", "ui_right")
	if arrow_direction:
		velocity.x = move_toward(velocity.x, final_speed*arrow_direction, speed)
	elif direction:
		velocity.x = move_toward(velocity.x, final_speed*direction, speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("default")

	move_and_slide()

func _process(delta):
	if inside_body and Input.is_action_just_pressed("juggle"):
		knife.throw(knife_force)

func _on_regular_body_exited(body):
	if body.get_name().contains("Knife"): 
		inside_body = false
		knife.glow(false)
	
func _on_good_body_exited(body):
	if body.get_name().contains("Knife"):
		inside_body = false
		knife.glow(false)


func _on_regular_body_entered(body):
	if body.get_name().contains("Knife"):
		inside_body = true
		knife = body
		knife_force = 2
		knife.glow(true)

func _on_good_body_entered(body):
	if body.get_name().contains("Knife"):
		inside_body = true
		knife = body
		knife_force = 3
		knife.glow(true)

func victory():
	$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("victory")
