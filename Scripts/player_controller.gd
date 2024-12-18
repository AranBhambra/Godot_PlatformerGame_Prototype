extends KinematicBody2D


var speed : int = 250 
var jump_speed : int = 200
var gravity : int = 250 
var velocity = Vector2()
onready var animation = $AnimationPlayer
var coins = 0
const BOOMERANG = preload("res://Scene/shootBoomerang.tscn")
var PlayerLife=3

#This is a fuction for player movement 
func get_input(delta): 
	velocity.x = 0 
	#This is for the player to move right
	if Input.is_action_pressed("move_right"):
		animation.play("movement")
		velocity.x += speed
		
	#This is for the player to move left
	if Input.is_action_pressed("move_left"):
		animation.play("movement")
		velocity.x -= speed
		
		
	#This is for the player to jump 
	if Input.is_action_just_pressed("jump"):
		animation.play("notMoving")
		#Checks to see if player is on the ground or not 
		if ( is_on_floor()):
			velocity.y -=jump_speed
			$JumpSound.play()
			
	if Input.is_action_just_pressed("shoot"):
		var direction = 1 if not $Sprite.flip_h else -1
		var f = BOOMERANG.instance()
		f.direction = direction
		get_parent().add_child(f)
		f.position.y = position.y
		f.position.x = position.x + 25 * direction
		

	# gravity 
	velocity.y += gravity * delta 
	velocity = move_and_slide(velocity, Vector2.UP)
	pass 


#Process the physics?
func _physics_process(delta):
	get_input(delta)

func getCoin():
	coins+=1


func _on_Fall_End_body_entered(body):
	if body.name == "KinematicBody2D":
		if Global.lives == 1:
			get_tree().change_scene("res://Scene/GameOver.tscn")
		
		else:
			Global.lives = Global.lives - 1
			get_tree().change_scene("res://Scene/SceneMain.tscn")



func _on_Win_End_body_entered(body):
	if body.name == "KinematicBody2D":
		get_tree().change_scene("res://Scene/WinScreen.tscn")

func add_coin():
	coins = coins + 1

func TakeDamage(damage):
	PlayerLife-=damage
	$AnimatedSprite.play("Hit")
	print("Taking Damage")
