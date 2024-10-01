extends Node2D

var last_dir = Vector2.RIGHT
var frame:float = 0.125

const SQUARE_DIMENSION = 16

var parts = 1

var count = 0

@onready var part = preload("res://part.tscn")

var t: float = 0.0

func _ready():
	var p = part.instantiate()
	p.set_row_col(10, 10)
	add_child(p)
	
func generate_new_piece():
	var prev = get_child(0)
	var p = part.instantiate()
	p.set_row_col(prev.row, prev.col)
	p.position = Vector2(p.row * SQUARE_DIMENSION, p.col * SQUARE_DIMENSION)
	add_child(p)
	parts += 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left") and last_dir != Vector2.RIGHT:
		last_dir = Vector2.LEFT
	elif Input.is_action_just_pressed("right") and last_dir != Vector2.LEFT:
		last_dir = Vector2.RIGHT
	elif Input.is_action_just_pressed("up") and last_dir != Vector2.DOWN:
		last_dir = Vector2.UP
	elif Input.is_action_just_pressed("down") and last_dir != Vector2.UP:
		last_dir = Vector2.DOWN
	t += delta
	if t >= frame:
		count += 1
		t -= frame
		move()
	
func move():
	var p = get_child(0)
	p.set_prev_row_col()
	p.prev_row = p.row 
	p.prev_col = p.col 
	p.row += 1 * last_dir.x
	p.col += 1 * last_dir.y
	p.position = Vector2(p.row * SQUARE_DIMENSION, p.col * SQUARE_DIMENSION)
	if p.row < 0 or p.row > 20 or p.col < 0 or p.col > 20:
		get_parent().game_over()
	if parts > 1:
		for i in range(1, parts):
			var ch = get_child(i)
			if ch.row == p.row and ch.col == p.col:
				get_parent().game_over()
			var prev = get_child(i - 1)
			ch.prev_row = ch.row
			ch.prev_col = ch.col 
			ch.row = prev.prev_row 
			ch.col = prev.prev_col 
			ch.position = Vector2(ch.row * SQUARE_DIMENSION, ch.col * SQUARE_DIMENSION)
