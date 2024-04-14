extends Node2D

var row:PackedScene = preload("res://game/board_pieces/row.tscn")
var rows:Array
var color_shift:bool = false 
var board_state: Array


func _ready():
	scale.x = (3.0 / Global.board_size)
	scale.y = (3.0 / Global.board_size)

	for i in range(Global.board_size):
		var r = row.instantiate()
		
		if !color_shift and (i%2 == 0):
			r.color_shift = true
		elif color_shift and (i%2 == 1):
			r.color_shift = true
		else:
			r.color_shift = false
		rows.append(r)
		r.position.y = find_pos(Global.board_size, i)
		add_child(r)


func update_board():
	for i in range(Global.board_size):
		var row_start = i * Global.board_size
		rows[i].row_state = board_state.slice(row_start, row_start + (Global.board_size))
		rows[i].update_row()


func find_pos(board_size, pos): #determine position of cell
	
	if board_size%2 == 0: #if even
		var half_board = (board_size/2)-1
		if pos <= half_board:
			return (((pos - 1) - half_board) * Global.pos_shift + (Global.pos_shift / 2))
		elif pos > half_board:
			return (((pos - half_board) * Global.pos_shift) - (Global.pos_shift / 2))
	
	elif board_size%2 == 1: #if odd)
		var half_board = floor(board_size/2)
		if pos == half_board:
			return 0
		elif pos < half_board:
			return (pos - half_board) * Global.pos_shift
		elif pos > half_board:
			return ((pos - half_board) * Global.pos_shift)
		
