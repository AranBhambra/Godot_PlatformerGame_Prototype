extends Area2D

signal coin_collected

func _on_Coin_body_entered(body):
	$SoundCoinCollect.play()
	$bounceAnimation.play("BounceCoin")
	emit_signal("coin_collected")
	


func _on_bounceAnimation_animation_finished(anim_name):
	queue_free()
