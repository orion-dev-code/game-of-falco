extends Area2D

export var pos_x = 0
export var pos_y = 0
export var duration =  float(0)
var start_pos = Vector2()

func _ready():
	
	$Timer.wait_time = duration *2
	$Timer.start()
	start_pos = position
	pass

func move():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($".","position",Vector2(pos_x,pos_y),duration)
	tween.tween_property($".","position",start_pos,duration)
	pass




func _on_Timer_timeout():
	move()
	pass # Replace with function body.
