extends Label

var score: int
# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0

func _get_score() -> int:
	return self.score

func _plus_score():
	score = score + 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
