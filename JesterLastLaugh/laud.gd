extends Node2D

var index: int = 0
var subindex: int = 0
var shape_index: int = 0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@export var tempo: float = 120
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
		0, 0, 1, 1,
		1, 1, 0, 0,
	]
]

func _ready():
	timer.one_shot = false
	timer.wait_time = 60.0 / tempo
	timer.connect("timeout",  _black)

func _process(delta):
	pass

func _black():
	var shape = shapes[0]
	var start = (len(shape) / 4.0 - subindex - 1) * 4
	for i in range(start, start + 4):
		var string_index = i % 4
		
		if shape[i] == 1:
			strings[string_index].add_note()
	
	subindex += 1
	
	if subindex >= len(shape) / 4:
		subindex = 0
