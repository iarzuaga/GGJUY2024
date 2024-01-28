extends Sprite2D

@onready var sprite_normal = preload("res://assets/king.png")
@onready var sprite_win = preload("res://assets/king_win.png")
@onready var sprite_lose = preload("res://assets/king_lose.png")
@onready var audio_stream = $AudioStreamPlayer2D
@onready var stream_win = preload("res://menu/assets/sounds/clash-royale-laugh.mp3")
@onready var stream_lose = preload("res://menu/assets/sounds/groan-male-epic-stock-media-1-00-00.mp3")

func _ready():
	pass

func _process(_delta):
	pass

func set_state(state: int):
	if state == -1:
		texture = sprite_lose
		audio_stream.stream = stream_lose
		audio_stream.play()
	elif state == 1:
		texture = sprite_win
		audio_stream.stream = stream_win
		audio_stream.play()
	else:
		texture = sprite_normal
