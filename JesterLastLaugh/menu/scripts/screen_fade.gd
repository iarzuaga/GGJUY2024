extends ColorRect

var is_showed: bool = false
var alpha: float = 0

func _ready():
	pass

func _process(delta):
	if is_showed:
		alpha += delta
		if alpha > 1: alpha = 1
	else:
		alpha -= delta
		if alpha < 0: alpha = 0
	
	color = Color(0.0, 0.0, 0.0, alpha)

func fade():
	is_showed = true
	
func unfade():
	is_showed = false
