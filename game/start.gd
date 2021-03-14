extends Node2D

onready var man = $manual

func _input(event):
	if event.is_action_pressed("start"):
		get_tree().change_scene("res://Main.tscn")
	if event.is_action_pressed("select"):
		man.visible = !man.visible
	if event.is_action_pressed("esc"):
		get_tree().quit()
