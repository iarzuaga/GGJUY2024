extends CharacterBody2D
var char_speed = 400
var char_force = 800
var knife_cadence = 1
var knife_ready = true
@onready var prefab_knife:PackedScene=preload("res://FruitNinja/Escenas/knife.tscn")
@onready var timer:Timer=$Timer
@onready var animation = $AnimationPlayer
@onready var sound_throw_knife = $AudioStreamPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",reset_knife_ready)
	timer.wait_time = knife_cadence
	animation.play("idle")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.x == 0 && animation.current_animation == "run":
		animation.play("idle")

func object_type():
	return "char"
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		if direction == 1:
			$jesterSprite.flip_h = false
		else:
			$jesterSprite.flip_h = true
		animation.play("run")
		velocity.x = direction * char_speed
		#if position.x < 500 && :
			#animation.play("run")
			#velocity.x = direction * char_speed
	else:
		velocity.x = move_toward(velocity.x, 0, char_speed)
	move_and_slide()

func reset_knife_ready():
	knife_ready=true
	timer.stop()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT && knife_ready:
		#sound_throw_knife.autoplay()
		timer.start()
		knife_ready=false
		var ammunition = prefab_knife.instantiate()
		add_child(ammunition)
		ammunition.start_movement((get_parent().get_node("Camera2D").get_global_mouse_position()-global_position).normalized(),char_force)

func _on_body_entered(body):
	print("CHAR CONTACT")
