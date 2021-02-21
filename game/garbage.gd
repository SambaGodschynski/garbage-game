# GARBAGE
extends Node2D

var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position.y =  self.position.y + speed
	if self.position.y > 1000:
		self.queue_free()
