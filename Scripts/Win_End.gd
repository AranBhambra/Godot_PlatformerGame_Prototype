extends Area2D

func _on_Win_End_body_entered(body):
	if body.name == "KinematicBody2D":
		get_tree().change_scene("res://YouWinMenu.tscn")
