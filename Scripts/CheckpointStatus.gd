extends Area2D

onready var animatedFlag=false

func _on_Checkpoint_body_entered(body):
	if body.name == "KinematicBody2D":
		$FlagAnimation.play("Flag")
		Checkpoint.last_position=global_position
		
func _on_FlagAnimation_animation_finished(anim_name):
	animatedFlag = true
