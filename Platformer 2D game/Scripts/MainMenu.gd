extends Control

func _ready():
	Globale.pause_menu = false
	pass

func _on_Play_pressed():


	get_tree().change_scene("res://Scenes/Level1.tscn")
	pass # Replace with function body.


func _on_Quit_pressed():


	get_tree().quit()
	pass # Replace with function body.
