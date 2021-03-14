extends Node2D

var banana = "res://garb_banana.tscn"
var bottle = "res://garb_bottle.tscn"
var paper = "res://garb_paper.tscn"
var drop_speed_secs = 1.5
var t = 0
var last_drop_t = 0
var passed_t = 0
var max_width = 954
var garbages = []
onready var player = $Player
onready var misc = $misc
onready var point_label = $misc/points
onready var lifes_label = $misc/lifes
onready var verloren = $misc/Verloren
onready var gordon = $Player/gordon
onready var music = $misc/music
var points = 0
var gameover = false
var lifes = 5
var gut_sounds = ["misc/gut1", "misc/gut2", "misc/gut3", "misc/gut4", "misc/gut5"]
var schlecht_sounds = ["misc/falsch1", "misc/falsch2", "misc/falsch3", "misc/falsch4", "misc/falsch5", "misc/falsch6"]
var last_gut_sound = 0
var last_schlecht_sound = 0
var can_color = "blue"
var level_points = 20
var level = 1


func add_garbage(name):
	var garb = load(name).instance()
	garb.position.x = randf() * max_width
	garb.position.y = -10
	garb.scale.x = 0.4
	garb.scale.y = 0.4
	garb.speed = garb.speed + (level-1)
	add_child(garb)
	garbages.append(garb)
	
func set_color(color):
	can_color = color
	player.set_color(color)
	
func _ready():
	update_points()
	set_color("green")

func next_garbage():
	var random_number = randi() % 3
	if random_number == 0:
		return banana
	if random_number == 2:
		return paper
	if random_number == 1:
		return bottle

func good():
	points += 10
	get_node(gut_sounds[last_gut_sound]).play()
	last_gut_sound = (last_gut_sound + 1) % len(gut_sounds)
	update_points()

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().change_scene("res://start.tscn")
	if gameover == false:
		return
	if t < 5:
		return
	if event.is_pressed() == false:
		return
	get_tree().change_scene("res://start.tscn")

func set_gameover():
	gameover = true
	verloren.visible = true
	player.active = false
	gordon.visible = true
	t = 0

func bad():
	points -= 5
	lifes -= 1
	if lifes < 0:
		set_gameover()
	get_node(schlecht_sounds[last_schlecht_sound]).play()
	last_schlecht_sound = (last_schlecht_sound + 1) % len(schlecht_sounds)
	update_points()

func next_level():
	self.can_color = player.set_next_color()
	level += 1
	drop_speed_secs = max(0.1, drop_speed_secs - 0.2)
	music.pitch_scale = min(2, music.pitch_scale + 0.025)	
func hit(garbage):
	var color = garbage.get_color()
	if color == can_color:
		good()
	else:
		bad()
	if points >= level * level_points:
		next_level()

func update_points():
	point_label.text = str(points)
	lifes_label.text = str(lifes)


func is_gabage_hit():
	var my_bounds_x0 = player.position.x - 50
	var my_bounds_y0 = player.position.y - 50
	var my_bounds_x1 = player.position.x + 50
	var my_bounds_y1 = player.position.y + 50
	for child in self.get_children():
		if child == player or child == misc:
			continue
		var garbage = child
		if 	garbage.position.x >= my_bounds_x0 \
		and garbage.position.x <= my_bounds_x1 \
		and garbage.position.y >= my_bounds_y0 \
		and garbage.position.y <= my_bounds_y1:
			hit(garbage)
			garbage.queue_free()

func _process(delta):
	t = t + delta
	if gameover:
		return
	passed_t = t - last_drop_t
	if passed_t > drop_speed_secs:
		var garbage = next_garbage()
		add_garbage(garbage)
		last_drop_t = t
	is_gabage_hit()
