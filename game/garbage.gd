# GARBAGE
extends Node2D

func get_color():
	if get_child(0).name == "garb_banana":
		return "green"
	if get_child(0).name == "garb_bottle":
		return "grey"
	if get_child(0).name == "garb_paper":
		return "blue"

var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position.y =  self.position.y + speed
	if self.position.y > 1000:
		self.queue_free()
