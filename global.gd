extends Node

var board_size:int = clamp(10,3,10)
var player_count:int = clamp(2,2,4)
var pos_shift:int = 210 #position shift of each box from center
var latest_box: int
var delete_last_box: int = 3
