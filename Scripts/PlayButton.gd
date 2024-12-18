extends Button




func _on_PlayButton_pressed():
	Global.lives = Global.max_lives
	Checkpoint.last_position = null
	get_tree().change_scene("res://Scene/SceneMain.tscn")
