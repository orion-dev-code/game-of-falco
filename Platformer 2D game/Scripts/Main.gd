extends Node2D


var score = 0
onready var anim = $Player/AnimationPlayer

func _ready():
	# Connecter les signaux de toutes les pièces dans la scène
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("coin_collected", self, "_on_coin_collected")

func _on_coin_collected():
	score += 1
	print("Score: ", score)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		anim.play("Death")
		get_tree().reload_current_scene()
