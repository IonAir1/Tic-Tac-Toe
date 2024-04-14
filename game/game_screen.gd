extends Control

var board:Array
var curr_player: int = 1
var players:Array


func _ready():
	for i in range(Global.board_size*Global.board_size):
		board.append(0)
	for i in range(Global.player_count):
		players.append([])
	print(board_to_string(board))


func _process(delta):
	if Input.is_action_just_released("enter"):
		input_play(int($LineEdit.text))
		print(board_to_string(board))


func input_play(cell): #lets the player take a turn
	if board[cell] == 0:
		board[cell] = curr_player
		players[curr_player-1].append(cell)
	else:
		print("cell is already taken")
	
	if(check_for_win(curr_player)):
		print("player %s has won" % curr_player)
	
	curr_player += 1
	if curr_player > Global.player_count:
		curr_player = 1


func check_for_win(chosen_player): #check if player won; player number as input
	var player = players[chosen_player-1]
	for cell in player:
		if player.has(cell-1) and player.has(cell+1):
			return true
		if player.has(cell-Global.board_size) and player.has(cell+Global.board_size):
			return true
	return false


func board_to_string(board): #convert board list to a printable string
	var board_string:String
	for row in range(Global.board_size):
		for column in range(Global.board_size):
			board_string += str(board[(row*Global.board_size)+column]) + " "
		board_string += "\n\n"
	return board_string
