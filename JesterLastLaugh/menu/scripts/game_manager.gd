extends Node2D

@export var difficulty: int = 0
@export var time_to_start: float = 3.0
var gold: int = 0
var is_game_winned: bool = false
var is_game_ended: bool = false
var current_game_node: Node = null
var guill_node: Node = null
var is_paused: bool = true
var timer_to_start: float = 0
@onready var gold_counter = $Camera2D/Control/GoldCounter
@onready var king = $Camera2D/King
@onready var pause_ui = $PauseBg
@onready var fade = $ScreenFade
@onready var timer = $Timer
@onready var label = $PauseBg/PauseMenu/Label
@onready var guillotine_scene = preload("res://guillotine/guillotine.tscn")
@onready var games = [
	preload("res://laudgame/note_game.tscn"),
	preload("res://juggling/scene/juggling.tscn"),
	#preload("res://FruitNinja/Escenas/fruitNinja.tscn"),
	preload("res://Osu/Escenas/MainScene.tscn"),
]
var played = []
var index = 0
var try_count = 0

func _ready():
	gold_counter.set_gold(0)
	play_game()

func play_game():
	var rng = RandomNumberGenerator.new()
	
	index = rng.randi_range(0, len(games) - 1)
	while index in played:
		index = rng.randi_range(0, len(games) - 1)
	
	played.append(index)
	
	if len(played) >= 4:
		played = []
	
	load_game(index)
	
func load_game(index: int):
	if current_game_node:
		remove_child(current_game_node)
	
	king.set_state(0)
	timer.stop()
	is_game_ended = false
	is_game_winned = false
	is_paused = true
	pause_ui.show()
	var game: PackedScene = games[index]
	var node: Node = game.instantiate()
	add_child(node)
	current_game_node = node
	node.set_difficulty(1)
	timer_to_start = time_to_start

func _process(delta: float):
	timer_to_start -= delta
	
	label.text = "Game starts in " + str(floorf(timer_to_start + 1))
	
	if timer_to_start <= 0 and is_paused:
		pause_ui.hide()
		is_paused = false
		if current_game_node:
			current_game_node.start()
		if guill_node:
			guill_node.start()
			call_in(king_happy, 1.0)

func king_happy():
	king.set_state(1)
	call_in(redirect_menu, 6)
	
func redirect_menu():
	get_tree().change_scene_to_file('res://menu/scenes/menu.tscn')
	
func add_gold(amount: int):
	gold += amount
	gold_counter.set_gold(gold)

func end_game(winned: bool):
	is_game_winned = winned
	is_game_ended = true
	
	var state: int = -1
	king.set_state(state)
	
	if is_game_winned:
		state = 1
	else:
		try_count += 1
		if try_count >= 2:
			call_in(start_guillotine, 5.0)
			return
	
	call_in(start_change_scene, 3.0)

func start_guillotine():
	fade.fade(instance_guillotine)
	
func instance_guillotine():
	if current_game_node:
		remove_child(current_game_node)
	
	king.set_state(0)
	timer.stop()
	is_game_ended = false
	is_game_winned = false
	is_paused = true
	pause_ui.show()
	var game: PackedScene = games[index]
	var node: Node = guillotine_scene.instantiate()
	add_child(node)
	current_game_node = null
	guill_node = node
	timer_to_start = time_to_start
	fade.unfade()

func start_change_scene():
	fade.fade(change_scene)
	
func change_scene():
	play_game()
	fade.unfade()
	
func call_in(f, time_in_sec: float):
	if timer:
		remove_child(timer)
	
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", f)
	timer.one_shot = true
	timer.wait_time = time_in_sec
	timer.start(0)
