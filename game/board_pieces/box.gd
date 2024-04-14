extends MeshInstance2D

var color_shift:bool = false

func _ready():
	if color_shift:
		modulate = Color(0.75,0.75,0.75)
	else:
		modulate = Color(1,1,1)
