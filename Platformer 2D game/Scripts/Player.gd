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
var is_dead = false
var is_attacking = false

func _ready():
	$Timer.start()
	start_position = position

	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("player_touched", self, "_on_player_touched")

	# Connecter le signal d'animation terminé
	#anim.connect("animation_finished", self, "_on_Attack_animation_finished")

func _physics_process(delta):
	$Camera2D/coins/coins_number.text = str(Globale.coins)
	$Camera2D/Label.text = str(Globale.timer)
	#move
	if is_dead:
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
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, resistance)

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		anim.play("attack")

func _on_Attack_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false

func _on_player_touched():
	if not is_dead:
		is_dead = true
		anim.play("death")
		# Jouer le son du piège ici
		$AudioServer.play(trap_sound)
		yield(anim, "animation_finished")
		position = start_position
		velocity = Vector2.ZERO
		is_dead = false



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Timer_timeout():
	Globale.timer += 1
	pass # Replace with function body.
