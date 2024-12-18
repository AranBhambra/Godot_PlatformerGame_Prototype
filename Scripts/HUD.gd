extends CanvasLayer

var coins = 0

func _ready():
	$Coins.text = String(coins)
	load_hearts()




func _on_coin_collected():
	coins = coins + 1
	_ready()


func load_hearts():
	$Heart_Full.rect_size.x = Global.lives * 53
	$Heart_Empty.rect_size.x = (Global.max_lives - Global.lives) * 53
	$Heart_Empty.rect_position.x = $Heart_Full.rect_position.x + $Heart_Full.rect_size.x * $Heart_Full.rect_scale.x
	
