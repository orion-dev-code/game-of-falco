extends Node2D

onready var anime = $Trap1/AnimationPlayer

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
