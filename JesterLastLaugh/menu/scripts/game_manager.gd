extends Node2D

var gold: int = 0

@onready var gold_counter = $Camera2D/Control/GoldCounter
@onready var games = [
	preload("res://laudgame/note_game.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	gold_counter.set_gold(0)
	
	var game: PackedScene = games[0]
	var node: Node = game.instantiate()
	node.set_gold_func(add_gold)
	add_child(node)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass
	
func add_gold(amount: int):
	gold += amount
	gold_counter.set_amount(gold)
