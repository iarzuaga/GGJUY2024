extends CharacterBody2D
@onready var animation = $AnimatedSprite2D
func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if position.distance_to(event.position) < 33:
			animation.play("Circle_Right")
		

func _on_animated_sprite_2d_animation_finished():
	queue_free()
