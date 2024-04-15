extends Control

var board:Array
var curr_player: int = 1
var players:Array
var delete_history:Array


func _ready():
	
	for i in range(Global.board_size*Global.board_size):
		board.append(0)
	for i in range(Global.player_count):
		players.append([])
	
	#print(board_to_string(board))
	
	for row in $CenterContainer/Board.get_children():
		for box in row.get_children():
			box.get_node("button").pressed.connect(on_box_update)


func _process(delta):
	pass
	
	#if Input.is_action_just_released("enter"):
		#input_play(int($LineEdit.text))
		#print(board_to_string(board))


func input_play(cell): #lets the player take a turn
	if board[cell] == 0:
		board[cell] = curr_player
		players[curr_player-1].append(cell)
	else:
		print("cell is already taken")
		return
	
	delete_box(Global.delete_last_box)

	curr_player += 1
	if curr_player > Global.player_count:
		curr_player = 1
	$CenterContainer/Board.board_state = board
	$CenterContainer/Board.update_board()

	if(check_for_win(curr_player)):
		print("player %s won" % curr_player)
		Global.winner = ("player %s won" % curr_player)
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	
	if !board.has(0): #check for draw
		Global.winner = "Game ended in draw"
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")


func delete_box(n):
	if n > 0:
		if len(players[curr_player - 1]) > n:
			delete_history.append({
				"box": players[curr_player - 1][0],
				"state": board[players[curr_player - 1][0]]
			})
			if len(delete_history) > 10:
				delete_history.remove_at(0)
			board[players[curr_player - 1][0]] = 0
			players[curr_player - 1].remove_at(0)


func check_for_win(chosen_player): #check if player won; player number as input
	var player = players[chosen_player-1]
	for cell in player:
		if player.has(cell-1) \
		and player.has(cell+1):
			if get_row(cell) == get_row(cell + 1) \
			and get_row(cell) == get_row(cell - 1):
				return true
				
		if player.has(cell-Global.board_size) \
		and player.has(cell+Global.board_size):
			if get_row(cell) == (get_row(cell - Global.board_size) + 1) \
			and get_row(cell) == (get_row(cell + Global.board_size) - 1):
				return true

		if player.has(cell - (Global.board_size - 1)) \
		and player.has(cell + (Global.board_size - 1)):
			if get_row(cell) == (get_row(cell - Global.board_size - 1) + 1) \
			and get_row(cell) == (get_row(cell + Global.board_size - 1) - 1):
				return true

		if player.has(cell-(Global.board_size+1)) \
		and player.has(cell+(Global.board_size+1)):
			if get_row(cell) == (get_row(cell - Global.board_size + 1) + 1) \
			and get_row(cell) == (get_row(cell + Global.board_size + 1) - 1):
				return true
				
	return false


func get_row(cell): #get row number
	return floor(cell / Global.board_size)


func board_to_string(board): #convert board list to a printable string
	var board_string:String = "\n\n\n\n\n\n"
	for row in range(Global.board_size):
		for column in range(Global.board_size):
			board_string += str(board[(row*Global.board_size)+column]) + " "
		board_string += "\n\n"
	return board_string


func undo():
	var prev = curr_player - 1
	if prev < 1:
		prev = Global.player_count
	
	if len(delete_history) > 0:
		board[delete_history[-1]["box"]] = delete_history[-1]["state"]
		players[prev - 1].insert(0, delete_history[-1]["box"])
		delete_history.remove_at(delete_history.size() - 1)
	
		if len(players[prev - 1]) > 0:
			board[players[prev - 1][-1]] = 0
			players[prev - 1].remove_at(players[prev - 1].size() - 1)
			curr_player = prev
	
	$CenterContainer/Board.update_board()


func on_box_update():
	input_play(Global.latest_box)


func _on_undo_pressed():
	undo()


func _on_home_pressed():
	Global.winner = ""
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
