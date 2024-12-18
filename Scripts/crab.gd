extends KinematicBody2D

var speed = 50
var velocity = Vector2()
export var direction = -1

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	
func _physics_process(delta):
	
	if is_on_wall():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20;
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity,Vector2.UP)
	


func _on_top_checker_body_entered(body):
	if body.name == "KinematicBody2D":
		$AnimatedSprite.play("crabDead")
		
		speed = 0
		

	if speed==0:
		queue_free()



func _on_sides_checker_body_entered(body):
	if body.name == "KinematicBody2D":
		if Global.lives == 1:
			get_tree().change_scene("res://Scene/GameOver.tscn")
		else:
			Global.lives = Global.lives - 1
			get_tree().change_scene("res://Scene/SceneMain.tscn")
	if body.name == "shootBoomerang":
		body.queue_free()
		queue_free()
