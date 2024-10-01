extends Node2D

var prev_row = null
var prev_col = null
var row = null
var col = null

var frame = 0.5
var t = 0.0

func set_row_col(r, c):
	row = r
	col = c
	
func set_prev_row_col():
	prev_row = row
	prev_col = col
