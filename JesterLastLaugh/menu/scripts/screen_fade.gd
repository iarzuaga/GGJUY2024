extends ColorRect

var is_showed: bool = false
var alpha: float = 0
var callback = null
var called = false

func _ready():
	pass

func _process(delta):
	if is_showed:
		alpha += delta
		if alpha > 1: 
			alpha = 1
			if callback and not called:
				callback.call()
				called = true
	else:
		alpha -= delta
		if alpha < 0:
			alpha = 0
			if callback and not called:
				callback.call()
				called = true
	
	color = Color(0.0, 0.0, 0.0, alpha)

func fade(f = null):
	is_showed = true
	called = false
	callback = f
	
func unfade(f = null):
	is_showed = false
	called = false
	callback = f
