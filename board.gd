extends Node2D

var rows = 19
var cols = 19

const SQUARE_DIMENSION = 16

@onready var start_screen: Control = $StartScreen
@onready var end_screen: Control = $EndScreen

@onready var snake = preload("res://snake.tscn")
@onready var target = preload("res://target.tscn")

@onready var score_label: Label = $EndScreen/ScoreLabel

var is_start = true
var is_end = false

var sn = null
var ta = null

var score = 0
var final_score = 0

func _ready() -> void:
	start_screen.show()

func _process(_delta: float) -> void:
	if not is_end and not is_start:
		if sn.get_child(0).row == ta.row and sn.get_child(0).col == ta.col:
			ta.row = randi_range(0, rows)
			ta.col = randi_range(0, cols)
			ta.position = Vector2(ta.row * SQUARE_DIMENSION, ta.col * SQUARE_DIMENSION)
			sn.generate_new_piece()
			score += 1
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("ui_accept") and is_start:
		generate_snake()
	
	if Input.is_action_just_pressed("ui_accept") and is_end:
		get_tree().reload_current_scene()
	if is_end:
		sn.hide()
		ta.hide()

func game_over():
	is_start = false
	is_end = true
	final_score = score
	show_end_screen()
	
func generate_snake():
	is_start = false
	is_end = false
	start_screen.hide()
	var s = snake.instantiate()
	add_child(s)
	var t = target.instantiate()
	t.row = randi_range(0, rows)
	t.col = randi_range(0, cols)
	t.position = Vector2(t.row * SQUARE_DIMENSION, t.col * SQUARE_DIMENSION)
	add_child(t)
	sn = get_child(2)
	ta = get_child(3)
	
func show_end_screen():
	end_screen.show()
	score_label.text = str(final_score)
