extends Sprite2D

@onready var sprite_normal = preload("res://assets/king.png")
@onready var sprite_win = preload("res://assets/king_win.png")
@onready var sprite_lose = preload("res://assets/king_lose.png")

func _ready():
	pass

func _process(_delta):
	pass

func set_state(state: int):
	if state == -1:
		texture = sprite_lose
	elif state == 1:
		texture = sprite_win
	else:
		texture = sprite_normal
