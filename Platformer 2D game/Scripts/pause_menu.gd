extends Control




func _on_Resume_pressed():
	Globale.pause_menu = false
	pass # Replace with function body.


func _on_retry_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_back_pressed():
	Engine.time_scale = 1
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	pass # Replace with function body.
