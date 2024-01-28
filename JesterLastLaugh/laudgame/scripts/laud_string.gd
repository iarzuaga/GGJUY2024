extends Node

@export var note_speed: float = 100.0
@export var action = "ui_left"
@export var letter = "h"
@export var sound: String = "res://laudgame/assets/sounds/Note_1.wav"
@onready var wrong_sound_stream = preload("res://laudgame/assets/sounds/Wrong_Note.wav")
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var area2d = $Area2D
@onready var spawnpoint = $SpawnPoint
@onready var label = $Label
@onready var color_rect = $ColorRect
var string_on = load("res://laudgame/assets/textures/string_on.png")
var string_off = load("res://laudgame/assets/textures/string_off.png")
var notes_inside = []
var play_time = 0
var mod_time = 0
var color_timer = 0.0
var sound_stream

func _ready():
	timer.connect("timeout", _reset_texture)
	area2d.connect("area_entered", _note_entered)
	area2d.connect("area_exited", _note_exited)
	label.text = letter
	color_rect.color = Color("FFFFFF", 0.0)
	sound_stream = load(sound)

func _process(delta):
	if Input.is_action_just_pressed(action):
		sprite.texture = string_on
		timer.start(0.3)
		color_timer = 0.5
		
		$AudioStreamPlayer2D.stream = sound_stream if len(notes_inside) != 0 else wrong_sound_stream
		$AudioStreamPlayer2D.play()
		
		for note in notes_inside:
			spawnpoint.kill_note(note)
		
	color_rect.color = Color("FFFFFF", color_timer / 1.0)
	color_timer -= delta
		
func _note_entered(area):
	notes_inside.append(area.get_parent())

func _note_exited(area):
	notes_inside.erase(area.get_parent())
	spawnpoint.fail_note(area.get_parent())

func _reset_texture():
	sprite.texture = string_off

func add_note():
	spawnpoint.spawn_note(note_speed)
