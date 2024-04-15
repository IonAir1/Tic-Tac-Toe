extends Control

@export var winner_text:Node
@export var player_text:Node
@export var size_text:Node
@export var max_text:Node
@export var game_scene:PackedScene


func _ready():
	winner_text.text = Global.winner
	player_text.text = "Players: " + str(Global.player_count)
	size_text.text = "Size: " + str(Global.board_size) + "x" + str(Global.board_size)
	if Global.delete_last_box > 0:
		max_text.text = "Max Shape: " + str(Global.delete_last_box)
	else:
		max_text.text = "Max Shape: None"


func _on_play_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_size_decrease_pressed():
	Global.board_size = clamp(Global.board_size - 1, 3, 10)
	size_text.text = "Size: " + str(Global.board_size) + "x" + str(Global.board_size)
	print("board size count changed to ", Global.board_size)
	
func _on_size_increase_pressed():
	Global.board_size = clamp(Global.board_size + 1, 3, 10)
	size_text.text = "Size: " + str(Global.board_size) + "x" + str(Global.board_size)
	print("board size count changed to ", Global.board_size)

func _on_player_decrease_pressed():
	Global.player_count = clamp(Global.player_count - 1, 2, 4)
	player_text.text = "Players: " + str(Global.player_count)
	print("player count changed to ", Global.player_count)

func _on_player_increase_pressed():
	Global.player_count = clamp(Global.player_count + 1, 2, 4)
	player_text.text = "Players: " + str(Global.player_count)
	print("player count changed to ", Global.player_count)

func _on_max_decrease_pressed():
	Global.delete_last_box = clamp(Global.delete_last_box - 1, 0, 10)
	if Global.delete_last_box > 0:
		max_text.text = "Max Shape: " + str(Global.delete_last_box)
	else:
		max_text.text = "Max Shape: None"
	print("max changed to ", Global.delete_last_box)

func _on_max_increase_pressed():
	Global.delete_last_box = clamp(Global.delete_last_box + 1, 0, 10)
	if Global.delete_last_box > 0:
		max_text.text = "Max Shape: " + str(Global.delete_last_box)
	else:
		max_text.text = "Max Shape: None"
	print("max changed to ", Global.delete_last_box)
