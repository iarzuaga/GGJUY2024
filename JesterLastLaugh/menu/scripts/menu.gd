extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://menu/scenes/game.tscn")


func _on_exit_pressed():
	get_tree().quit() 
