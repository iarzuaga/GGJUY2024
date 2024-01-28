extends Node2D

var cannon_cadence = 1.5
var cannon_array:Array[Node] = []
@onready var cannon_timer:Timer=$Timer
@onready var game_timer:Timer=$GameTimer
@onready var wait_timer:Timer=$initial_wait_time
var game_time = 30
var layers_floor:Array[int] = [3]
var layers_dish:Array[int] = [2]

var broken_dishes = 0

# Called when the node enters the scene tree for the first time.
func _ready():	
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
	wait_timer.connect("timeout",start_minigame)
	wait_timer.wait_time = 0.5
	wait_timer.start()
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

func game_timeout():
	cannon_timer.stop()
	game_timer.stop()
	if broken_dishes >= 15:
		get_parent().end_game(true)
	else:
		get_parent().end_game(false)

func start_minigame():
	wait_timer.stop()
	cannon_timer.connect("timeout",tell_cannon_to_shot)
	cannon_timer.wait_time = cannon_cadence

	game_timer.connect("timeout",game_timeout)
	game_timer.wait_time = game_time
	game_timer.start()
	
