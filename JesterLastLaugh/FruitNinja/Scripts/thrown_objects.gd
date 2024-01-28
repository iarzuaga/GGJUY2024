extends RigidBody2D

@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_movement(dir:Vector2,force:Vector2):
	apply_impulse(Vector2(force.x*dir.x,force.y*dir.y),position)
	#apply_impulse(Vector2(1000*0.5,1000*(-0.5)),position)
	
func object_type():
	return "plato"
	
func destroy():
	#Detengo objeto
	set_deferred("freeze", true)
	animation.play("break")
	
#func _input(event):
#	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#		print("clicked platos!")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "break":
		queue_free()
