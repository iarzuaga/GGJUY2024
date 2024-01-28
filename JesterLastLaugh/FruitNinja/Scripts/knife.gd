extends RigidBody2D

@onready var animation = $AnimationPlayer
@onready var sound_knife = $AudioStreamPlayer
@onready var mini_game_manager = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func object_type():
	return "knife"
	
func start_movement(dir:Vector2,force):
	sound_knife.play()
	position = Vector2(position.x,position.y)
	apply_impulse(Vector2(force*dir.x,force*dir.y),position)
	animation.play("spin")

func _on_body_entered(body):
	print("KnifeContact")
	var array_layers = mini_game_manager.to_binary(body.get_collision_layer())
	var colission_with_floor = mini_game_manager.some_element_in_A_is_in_B(array_layers,mini_game_manager.layers_floor)
	var olission_with_dish = mini_game_manager.some_element_in_A_is_in_B(array_layers,mini_game_manager.layers_dish)
	if colission_with_floor:
		print("destroy knife")
		#If knife touhes floor, delete the knife
		#animation.play("floor")
		queue_free()
	if olission_with_dish:
		#If knife touhes dish, delete the dish
		print("destroy dish")
		body.destroy()
