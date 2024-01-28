extends Node2D

var cannon_cadence = 1.5
var cannon_array:Array[Node] = []
@onready var timer:Timer=$Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",tell_cannon_to_shot)
	timer.wait_time = cannon_cadence

	cannon_array.append($cannon_r)
	cannon_array.append($cannon_l)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().add_gold(1)
	get_parent().end_game(false)
		
func tell_cannon_to_shot():
	#Disparo random del cañoñ 1 o 2
	cannon_array[randi_range (0,1)].shot_projectile()
	#cannon_array[1].shot_projectile()

func set_difficulty(value: int):
	# 0 1 2 3
	pass
	
func start():
	pass
