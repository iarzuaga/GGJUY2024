extends Control

var score: int
var score_per_circle : int

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0

func _score_plus():
	score = score + score_per_circle

func _get_score() -> int:
	return score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
