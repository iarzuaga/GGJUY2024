extends RigidBody2D

@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func object_type():
	return "knife"
	
func start_movement(dir:Vector2,force):
	position = Vector2(position.x,position.y)
	apply_impulse(Vector2(force*dir.x,force*dir.y),position)
	animation.play("spin")


func _on_body_entered(body):
	print("KnifeContact")
	if body.get_name() == "Floor":
		#animation.play("floor")
		queue_free()
	elif body.get_name() != "WallR" && body.get_name() != "WallL" && body.object_type() == "plato":
		body.destroy()
	#elif body.get_name() == "Floor1" || body.get_name() == "Floor2":
