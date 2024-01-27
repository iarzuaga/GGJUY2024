extends Node

@export var action = "ui_left"
@export var letter = "h"
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var area2d = $Area2D
@onready var spawnpoint = $SpawnPoint
@onready var label = $Label
var string_on = load("res://laudgame/string_on.png")
var string_off = load("res://laudgame/string_off.png")
var notes_inside = []
var play_time = 0
var mod_time = 0

func _ready():
	timer.connect("timeout", _reset_texture)
	area2d.connect("area_entered", _note_entered)
	area2d.connect("area_exited", _note_exited)
	label.text = letter

func _process(_delta):
	if Input.is_action_just_pressed(action):
		sprite.texture = string_on
		timer.start(0.3)
		
		for note in notes_inside:
			spawnpoint.kill_note(note)
		
func _note_entered(area):
	notes_inside.append(area.get_parent())

func _note_exited(area):
	notes_inside.erase(area.get_parent())
	spawnpoint.fail_note(area.get_parent())

func _reset_texture():
	sprite.texture = string_off

func add_note():
	spawnpoint.spawn_note()
