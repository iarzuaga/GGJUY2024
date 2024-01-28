extends Node2D

var index: int = 0
var subindex: int = 0
var shape_index: int = 0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@export var wait_between_shapes = 3
@export var wait_count = 0
@export var tempo: float = 100
@onready var timer: Timer = $Timer
@onready var strings: Array[Node] = [
	$Laud0,
	$Laud1,
	$Laud2,
	$Laud3
]
var shapes = [
	[
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1,
	],
	[
		1, 1, 0, 0,
		0, 0, 1, 1,
	],
	[
		1, 0, 0, 1,
		1, 0, 0, 1,
	],
	[
		1, 0, 0, 1,
		0, 1, 1, 0,
	],
	[
		0, 0, 0, 1,
		0, 0, 1, 0,
		0, 1, 0, 0,
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1,
		0, 0, 1, 0,
		0, 1, 0, 0,
		1, 0, 0, 0,
	],
	[
		1, 0, 0, 1,
		1, 0, 0, 1,
		1, 0, 0, 1,
		1, 0, 0, 1,
		0, 1, 1, 0,
	],
	[
		1, 0, 0, 1,
		0, 1, 1, 0,
		1, 0, 0, 1,
	]
]

func _ready():
	timer.one_shot = false
	timer.connect("timeout",  _black)
	
	index = rng.randi_range(0, len(shapes) - 1)

func stop():
	timer.stop()

func start():
	timer.start(60.0 / tempo)

func _black():
	if wait_count > 0:
		wait_count -= 1
		return
	
	var shape = shapes[index]
	var start = (len(shape) / 4.0 - subindex - 1) * 4
	for i in range(start, start + 4):
		var string_index = i % 4
		
		if shape[i] == 1:
			strings[string_index].add_note()
	
	subindex += 1
	
	if subindex >= len(shape) / 4:
		index = rng.randi_range(0, len(shapes) - 1)
		wait_count = wait_between_shapes
		subindex = 0

func set_speed(speed: float):
	for s in strings:
		s.note_speed = speed
