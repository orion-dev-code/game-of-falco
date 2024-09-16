extends KinematicBody2D


var attack = false
var motion = Vector2()
var grav = 500

func _ready():
	$Area2D2/CollisionShape2D.disabled =false
	pass

func _physics_process(delta):


	motion.y += grav*delta


	if attack == false :
		$AnimationPlayer.play("idle")
	if attack == true:
		position.x += (Globale.player_pos.x - position.x)/50
		
	move_and_collide(motion)
		
	pass
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		attack = true
		$AnimationPlayer.play("attack")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		attack = false
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		Globale.die = true
	pass # Replace with function body.


func _on_Area2D3_body_entered(body):
	if body.is_in_group("player"):
		$Area2D2/CollisionShape2D.disabled =true
		$Sprite.hide()
		$CPUParticles2D.emitting =true
		$Timer.start()
			
	pass # Replace with function body.





func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
