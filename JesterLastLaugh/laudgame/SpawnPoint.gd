extends Node2D

var note = preload("res://laudgame/note.tscn")

func _ready():
	pass

func _process(_delta: float):
	pass

func spawn_note():
	var node: Node = note.instantiate()
	node.position = self.position
	add_child(node)

func kill_note(node: Node):
	remove_child(node)

func fail_note(node):
	node.fail()