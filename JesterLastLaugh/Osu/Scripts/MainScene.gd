extends Node2D

@onready var timer:Timer=$Timer
@onready var packCircle:PackedScene = preload("res://Osu/Escenas/Circle.tscn")
var _number_generator: RandomNumberGenerator
var viewport_size: Vector2
var playable_zone: Array[Vector2] = []
#Centro Absoluto ViewPort

func _ready():
	viewport_size = get_viewport_rect().size
	_number_generator = RandomNumberGenerator.new()
	_number_generator.randomize()
	_get_playable_zone()
	timer.connect("timeout",_spawn_circles)
	timer.wait_time = 2
	timer.start()

func getViewportCenter() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2

func _get_playable_zone():
	var viewport_center:Vector2=getViewportCenter()
	var long_x = viewport_size.x / 2
	var long_y = viewport_size.y / 2
	
	var cordinates_down_left : Vector2 = Vector2(viewport_center.x - long_x / 2,viewport_center.y + long_y / 2)
	var cordinates_up_left : Vector2 = Vector2(viewport_center.x - long_x / 2,viewport_center.y - long_y)
	var cordinates_down_right : Vector2 = Vector2(viewport_center.x + long_x,viewport_center.y + long_y / 2)
	var cordinates_up_right : Vector2 = Vector2(viewport_center.x + long_x,viewport_center.y - long_y)
	
	playable_zone.append(cordinates_down_left)
	playable_zone.append(cordinates_up_left)
	playable_zone.append(cordinates_down_right)
	playable_zone.append(cordinates_up_right)

func _spawn_circles():
	var _random_num_x_position = _number_generator.randi_range(playable_zone[1].x,playable_zone[3].x)
	var _random_num_y_position = _number_generator.randi_range(playable_zone[3].y,playable_zone[2].y)

	var Circle: CharacterBody2D = packCircle.instantiate()
	Circle.position.x = _random_num_x_position
	Circle.position.y = _random_num_y_position
	add_child(Circle)
	
