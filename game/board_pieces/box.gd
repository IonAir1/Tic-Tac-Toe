extends Node2D


var color_shift:bool
var state:int
var box_number:int


func _ready():
	pass
	#if color_shift:
		#$background.modulate = Color(0.75,0.75,0.75)
	#else:
		#$background.modulate = Color(1,1,1)

func update_state():
	if state == 0:
		$p1.visible = false
		$p2.visible = false
		$p3.visible = false
		$p4.visible = false
	elif state == 1:
		$p1.visible = true
		$p2.visible = false
		$p3.visible = false
		$p4.visible = false
	elif state == 2:
		$p1.visible = false
		$p2.visible = true
		$p3.visible = false
		$p4.visible = false
	elif state == 3:
		$p1.visible = false
		$p2.visible = false
		$p3.visible = true
		$p4.visible = false
	elif state == 4:
		$p1.visible = false
		$p2.visible = false
		$p3.visible = false
		$p4.visible = true


func _on_button_pressed():
	Global.latest_box = box_number
