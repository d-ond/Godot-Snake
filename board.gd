extends Node2D

var rows = 19
var cols = 19

const SQUARE_DIMENSION = 16

@onready var snake = preload("res://snake.tscn")
@onready var target = preload("res://target.tscn")

func _ready() -> void:
	var s = snake.instantiate()
	add_child(s)
	var t = target.instantiate()
	t.row = randi_range(0, rows)
	t.col = randi_range(0, cols)
	t.position = Vector2(t.row * SQUARE_DIMENSION, t.col * SQUARE_DIMENSION)
	add_child(t)

func _process(_delta: float) -> void:
	var s = get_child(0)
	var t = get_child(1)
	
	if s.get_child(0).row == t.row and s.get_child(0).col == t.col:
		t.row = randi_range(0, rows)
		t.col = randi_range(0, cols)
		t.position = Vector2(t.row * SQUARE_DIMENSION, t.col * SQUARE_DIMENSION)
		s.generate_new_piece()
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func game_over():
	get_tree().reload_current_scene()
