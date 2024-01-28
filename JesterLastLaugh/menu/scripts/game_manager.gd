extends Node2D

@export var time_to_start: float = 3.0
var gold: int = 0
var is_game_winned: bool = false
var is_game_ended: bool = false
var current_game_node: Node = null
var is_paused: bool = true
var timer_to_start: float = 0
@onready var gold_counter = $Camera2D/Control/GoldCounter
@onready var king = $Camera2D/King
@onready var pause_ui = $PauseBg
@onready var games = [
	preload("res://laudgame/note_game.tscn"),
	preload("res://juggling/scene/juggling.tscn")
]

func _ready():
	gold_counter.set_gold(0)
	load_game(1)
	
func load_game(index: int):
	is_game_ended = false
	is_game_winned = false
	is_paused = true
	pause_ui.show()
	var game: PackedScene = games[index]
	var node: Node = game.instantiate()
	add_child(node)
	current_game_node = node
	timer_to_start = time_to_start

func _process(delta: float):
	print("asdsadd")
	timer_to_start -= delta
	
	$PauseBg/PauseMenu/Label.text = "Game starts in " + str(floorf(timer_to_start + 1))
	
	if timer_to_start <= 0 and is_paused:
		pause_ui.hide()
		is_paused = false
		current_game_node.start()
	
func add_gold(amount: int):
	gold += amount
	gold_counter.set_gold(gold)

func end_game(winned: bool):
	is_game_winned = winned
	is_game_ended = true
	
	var state: int = -1
	if is_game_winned:
		state = 1
	king.set_state(state)
