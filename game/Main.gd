extends Node2D

var banana = "res://garb_banana.tscn"
var bottle = "res://garb_bottle.tscn"
var paper = "res://garb_paper.tscn"
var drop_speed_secs = 1
var t = 0
var last_drop_t = 0
var passed_t = 0
var max_width = 954

func add_garbage(name):
	var garb = load(name).instance()
	garb.position.x = randf() * max_width
	garb.position.y = -10
	garb.scale.x = 0.4
	garb.scale.y = 0.4
	add_child(garb)

func _ready():
	pass
	
func next_garbage():
	var random_number = randi() % 3
	if random_number == 0:
		return banana
	if random_number == 2:
		return paper
	if random_number == 1:
		return bottle
func _process(delta):
	t = t + delta
	#print(t)
	passed_t = t - last_drop_t
	if passed_t > drop_speed_secs:
		var garbage = next_garbage()
		add_garbage(garbage)
		last_drop_t = t
