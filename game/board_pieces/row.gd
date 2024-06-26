extends Node2D


@export var box:PackedScene
var boxes:Array
var color_shift:bool = false
var row_state:Array
var row_number:int


func _ready():
	for i in range(Global.board_size): #instantiate boxes
		row_state.append(0)
		var b = box.instantiate()
		#if !color_shift and (i%2 == 0):
			#b.color_shift = true
		#elif color_shift and (i%2 == 1):
			#b.color_shift = true
		#else:
			#b.color_shift = false
		boxes.append(b)
		b.box_number = i + (row_number * Global.board_size)
		b.position.x = calc_pos(Global.board_size, i)
		add_child(b)


func update_row():
	for i in range(row_state.size()):
		boxes[i].state = row_state[i]
		boxes[i].update_state()


func calc_pos(board_size, pos): #calculate position of boxes
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
		
