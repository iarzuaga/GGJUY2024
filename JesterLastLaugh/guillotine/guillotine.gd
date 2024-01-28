extends Node2D

@onready var guillotine_s1 = $Guillotine/Guillotine
@onready var guillotine_s2 = $Guillotine/Guillotine2
@onready var hand1 = $Hand1
@onready var hand2 = $Hand2
@onready var head = $Head
@onready var blade = $Blade
@onready var blade_end_pos: float = $EndPoint.position.y
@onready var audio_stream = $AudioStreamPlayer2D
@onready var gphead = $gphead
@onready var gph1 = $gph1
@onready var gph2 = $gph3

var is_started: bool = false
var timer: float = 0
var blade_start_pos: float
var executed: bool = false

func _ready():
	blade_start_pos = blade.position.y

func _process(delta):
	if not is_started:
		return
	
	timer += delta
	blade.position.y = lerpf(blade_start_pos, blade_end_pos, pow(timer / 0.5, 3))
	
	if timer >= 0.5 and not executed:
		executed = true
		blade.visible = false
		guillotine_s1.visible = false
		guillotine_s2.visible = true
		head.visible = true
		head.freeze = false
		hand1.freeze = false
		hand2.freeze = false
		head.apply_impulse(Vector2(-100, 0), Vector2(0, 0))
		hand1.apply_impulse(Vector2(-90, 50), Vector2(0, 0))
		hand2.apply_impulse(Vector2(-40, 10), Vector2(0, 0))
		gphead.emitting = true
		gph1.emitting = true
		gph2.emitting = true

func start():
	audio_stream.play(0.1)
	audio_stream.autoplay = false
	is_started = true
