extends Node2D

var box:PackedScene = preload("res://game/board_pieces/box.tscn")
var boxes:Array
var color_shift:bool = false
var row_state:Array

func _ready():
	for i in range(Global.board_size):
		row_state.append(0)
		var b = box.instantiate()
		
		#if !color_shift and (i%2 == 0):
			#b.color_shift = true
		#elif color_shift and (i%2 == 1):
			#b.color_shift = true
		#else:
			#b.color_shift = false
		
		boxes.append(b)
		b.position.x = find_pos(Global.board_size, i)
		add_child(b)


func update_row():
	for i in range(row_state.size()):
		print(row_state)
		boxes[i].state = row_state[i]
		boxes[i].update_state()


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
		
