extends Node2D

var seconds_cadence = 3
var cannon_array:Array[Node] = []
@onready var timer:Timer=$Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",tell_cannon_to_shot)
	timer.wait_time = seconds_cadence

	cannon_array.append($cannon_r)
	cannon_array.append($cannon_l)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func tell_cannon_to_shot():
	#Disparo random del cañoñ 1 o 2
	#cannon_array[randi_range (0,1)].shot_projectile()
	cannon_array[1].shot_projectile()
