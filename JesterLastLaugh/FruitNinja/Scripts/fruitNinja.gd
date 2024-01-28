extends Node2D

var cannon_cadence = 1.5
var cannon_array:Array[Node] = []
@onready var timer:Timer=$Timer

var layers_floor:Array[int] = [3]
var layers_dish:Array[int] = [2]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",tell_cannon_to_shot)
	timer.wait_time = cannon_cadence

	cannon_array.append($cannon_r)
	cannon_array.append($cannon_l)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#get_parent().add_gold(1)
	#get_parent().end_game(false)
		
func tell_cannon_to_shot():
	#Disparo random del cañoñ 1 o 2
	cannon_array[randi_range (0,1)].shot_projectile()
	#cannon_array[1].shot_projectile()

func set_difficulty(value: int):
	# 0 1 2 3
	pass
	
func start():
	pass
	
func to_binary(num: int) -> Array[int]:
	var binary_string: String = ""
	var remainder: int

	while num > 0:
		remainder = num % 2
		binary_string = binary_string + str(remainder)
		num = num / 2
	
	var layers:Array[int] = []
	var layer_number = 1
	for i in range(binary_string.length()):
		var character = binary_string[i]
		if character == "1":
			layers.append(layer_number)
		layer_number+=1
	return layers

func some_element_in_A_is_in_B(A: Array, B: Array) -> bool:
	for element in A:
		if B.find(element) != -1:
			return true
	return false
