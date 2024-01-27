extends Node

@export var action = "ui_left"
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var area2d = $Area2D
@onready var spawnpoint = $SpawnPoint
@onready var label = $Label
var string_on = load("res://laudgame/string_on.png")
var string_off = load("res://laudgame/string_off.png")
var notes_inside = []

func _ready():
	timer.connect("timeout", _reset_texture)
	area2d.connect("area_entered", _note_entered)
	area2d.connect("area_exited", _note_exited)

func _process(_delta):
	if Input.is_action_just_pressed(action):
		label.set("theme_override_colors/font_color", Color(0.0, 0.0, 0.0))
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
	label.add_theme_color_override("font_color", Color("a6963e"))

func add_note():
	spawnpoint.spawn_note()
