extends KinematicBody2D


var grav = 500
var motion = Vector2()
var speed = 80
var attack = false
var dir = 1
var damage = false
var health = 30



func _physics_process(delta):
	if health ==0:
		$AnimationPlayer.play("die")
		yield(get_tree().create_timer(1.2),"timeout")
		queue_free()
		return
	if Globale.skel_damage == true:
		$AnimationPlayer.play("hurt")
		health -= 15
		damage = true
		Globale.skel_damage = false
		return
	if is_on_wall() or !$RayCast2D.is_colliding():
		dir = dir*(-1)
		$".".scale.x = $".".scale.x * (-1)
	if attack == true:
		return
	motion.x = speed *dir
	if !is_on_floor():
		motion.y += grav * delta
	$AnimationPlayer.play("run")
	motion =  move_and_slide(motion,Vector2.UP)

	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		speed += 50
	pass # Replace with function body.

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		speed -= 50
	pass # Replace with function body.


func _on_Area2D3_body_entered(body):
	if body.is_in_group("player"):

		attack = true
		$Timer.start()
		$AnimationPlayer.play("attack")
	pass # Replace with function body.


func _on_Timer_timeout():
	attack = false
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		Globale.die = true
	pass # Replace with function body.



