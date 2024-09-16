extends Area2D

signal coin
onready var sound = $AudioStreamPlayer2D

func _ready():
	$AnimationPlayer.play("coin") 

func _on_Coin_body_entered(body):
	if body.name == "Player":
		sound.play()  # Joue le son
		emit_signal("coin")
		Globale.coins += 1 
		yield(get_tree().create_timer(0.1), "timeout")  # Attendre un court délai avant de supprimer la pièce
		queue_free()  # Supprime la pièce de la scène après un court délai
