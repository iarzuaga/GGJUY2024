extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	print("DummyContact")
	if body.get_name() != "WallR" && body.get_name() != "WallL" && body.get_name() != "Floor":
		body.destroy()

