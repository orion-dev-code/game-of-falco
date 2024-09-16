extends KinematicBody2D

var speed = 500
var max_speed = 150
var gravity = 480
var velocity = Vector2.ZERO
var jump = 170
var friction = 0.5
var resistance = 0.7

onready var sprite = $Sprite
onready var anim = $AnimationPlayer
onready var trap_sound = preload("res://asset/Son/Sound/explosion.wav") 



var start_position = Vector2()
var is_attacking = false
var minute  = false
func _ready():
	Globale.pause_menu = false
	$CollisionShape2D.disabled = false
	$Timer.start()
	start_position = position

	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("player_touched", self, "_on_player_touched")
	pass

func _physics_process(delta):
	if Globale.pause_menu ==true:
		Engine.time_scale =0
		$Camera2D/pause_menu.show()
	else:
		Engine.time_scale = 1
		$Camera2D/pause_menu.hide()
	Globale.player_pos = global_position
	if Globale.heart == 3:
		$Camera2D/heart.region_rect = Rect2(14.2,31.2,71,32)
	if Globale.heart == 2:
		$Camera2D/heart.region_rect = Rect2(14.2,31.2,47,32)
	if Globale.heart == 1:
		$Camera2D/heart.region_rect = Rect2(14.2,31.2,25,32)
	if Globale.heart ==0:
		get_tree().reload_current_scene()
		$Camera2D/heart.region_rect = Rect2(14.2,31.2,0,32)
	if Globale.die == true:
		die()
	
	#timer
	if Globale.second == 60:
		Globale.minute += 1
		Globale.second = 0
		minute = true
	if minute ==true :
			$Camera2D/Label.text = str(Globale.minute)+':'+str(Globale.second)
	if minute == false:
		$Camera2D/Label.text = str(Globale.second)


	$Camera2D/coins/coins_number.text = str(Globale.coins)

	if Globale.die == true:
		
		return

	if is_attacking:
		return

	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement_x != 0:
		anim.play("run")
		velocity.x += movement_x * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		sprite.flip_h = movement_x < 0

	if is_on_floor():
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, friction)
			anim.play("idle")
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y -= jump
			anim.play("jump")
	else:
		velocity.y += gravity * delta
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, resistance)



	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		anim.play("attack")

func _on_Attack_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false








func _on_Timer_timeout():
	Globale.second += 1
	pass # Replace with function body.

func die():

	$AnimationPlayer.play("Death")

	yield(get_tree().create_timer(0.65),"timeout")
	if Globale.heart ==1:
		get_tree().reload_current_scene()

	global_position = start_position
	$Timer2.start()
	Globale.die = false
	
	pass


func _on_Timer2_timeout():
	Globale.heart -=1
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("skeleton"):
		Globale.skel_damage = true

	pass # Replace with function body.


func _on_Button_pressed():
	Globale.pause_menu = true
	pass # Replace with function body.
