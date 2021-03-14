# TRASH CAN
extends Node2D

var speed = 10
var left_border = 51
var right_border = 954
var clunky = right_border / 2 
onready var green = $green
onready var grey = $grey
onready var blue = $blue
var active = true
var colors = {}
var color = ""

func _ready():
	self.position.x = clunky
	colors["green"] = green
	colors["grey"] = grey
	colors["blue"] = blue
	for col in colors.values():
		col.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active == false:
		return
	if Input.is_action_pressed("move_right") and self.position.x <= right_border:
		self.position.x =  self.position.x + speed
	if Input.is_action_pressed("move_left") and self.position.x >= left_border: 
		self.position.x = self.position.x - speed

func set_color(color):
	for col in colors.values():
		col.hide()
	colors[color].show()
	self.color = color

func set_next_color():
	var colors = self.colors.keys()
	var idx = colors.find(self.color)
	colors.remove(idx)
	colors.shuffle()
	set_color(colors[0])
	return self.color
