extends Camera2D

onready var player = get_node("/root/Level1/Player")

func _process(delta):
	global_position = player.global_position
