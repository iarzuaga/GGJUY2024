extends Node2D

#var initial_position:Vector2
var direction:Vector2
var dir_modifier:Vector2
var force_min = 600
var force_max = 800
var angle_min=4*PI/20
var angle_max=8*PI/20
@onready var prefab_throwable:PackedScene=preload("res://FruitNinja/Escenas/thrown_objects.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if position.x<0:
		dir_modifier.x=1
		dir_modifier.y=-1
	else:
		dir_modifier.x=-1
		dir_modifier.y=-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shot_projectile():
	var random_angle = randf_range(angle_min,angle_max)
	var force = Vector2(randi_range(force_min,force_max),randi_range(force_min,force_max))
	var ammunition = prefab_throwable.instantiate()
	add_child(ammunition)
	ammunition.start_movement(Vector2(dir_modifier.x*cos(random_angle),dir_modifier.y*sin(random_angle)),force)
