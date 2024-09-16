extends Node2D



func _ready():
	Globale.heart = 3
	pass




func _on_zone_body_entered(body):
	if body.is_in_group("player"):
		Globale.die = true
	pass # Replace with function body.
