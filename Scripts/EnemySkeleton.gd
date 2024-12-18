extends KinematicBody2D

enum ENEMYSTATE{IDLE, WALK, ATTACK, HURT, DEAD}
export (ENEMYSTATE) var currentState = ENEMYSTATE.WALK
export (ENEMYSTATE) var previousState = null

const UP=Vector2(0,-1)
const GRAVITY=25
const MAXSPEED=100
const MAXGRAVITY=50
var WeaponDamage = Global.lives-1

var movement=Vector2()
var moving_right=true
var player_in_range=false
var is_attacking = false

var skeleton_health = 10
var dead= false
var is_hit=false

onready var AnimatedSprite: = $AnimatedSprite
onready var HitBox: = get_node("Area2D/HitBox")

func _ready():
	pass




func _physics_process(delta):
	
	player_in_range=false
	
	if(!$DownRay.is_colliding() || $RightRay.is_colliding()):
		var collider=$RightRay.get_collider()
		if collider && collider.name=="KinematicBody2D":
			movement=Vector2.ZERO
			player_in_range=true
			
		elif(is_on_floor()):
			player_in_range=false
			moving_right=!moving_right
			scale.x=-scale.x
	
	#attack()
	#animate()
	executeState()
	move_enemy()
	

func attack():
	if player_in_range && AnimatedSprite.animation != "ATTACK":
		AnimatedSprite.play("ATTACK")
		is_attacking=true
	elif player_in_range && !AnimatedSprite.playing:
		is_attacking=false


func move_enemy():
	movement.y += GRAVITY
	
	if(movement.y > MAXGRAVITY):
		movement.y = MAXGRAVITY
		
	if(is_on_floor()):
		movement.y=0
	
	if !player_in_range:
		movement.x=MAXSPEED if moving_right else -MAXSPEED
	
	
	movement=move_and_slide(movement,UP)

func executeState():
	match currentState:
		ENEMYSTATE.IDLE:
			if is_hit:
				currentState=ENEMYSTATE.HURT
			if player_in_range:
				currentState = ENEMYSTATE.ATTACK
			elif !player_in_range:
				AnimatedSprite.play("WALK")
				movement.x=0
		ENEMYSTATE.WALK:
			if AnimatedSprite.animation!="WALK":
				AnimatedSprite.play("WALK")
			if player_in_range:
				currentState=ENEMYSTATE.ATTACK
			elif !player_in_range:
				movement.x=MAXSPEED if moving_right else -MAXSPEED
		ENEMYSTATE.ATTACK:
			AnimatedSprite.play("ATTACK")
			if AnimatedSprite.frame >= 7 && AnimatedSprite.frame <= 8:
				HitBox.disabled=false
				is_attacking=true
			else:
				HitBox.disabled=true
				is_attacking=false
				currentState=ENEMYSTATE.IDLE
		ENEMYSTATE.HURT:
			if AnimatedSprite.animation!="HIT":
				AnimatedSprite.play("HIT")
				movement.x=-76 if moving_right else 76
				movement.y=-50
			if skeleton_health<=0:
				dead=true
		ENEMYSTATE.DEAD:
			queue_free()

func changeState():
	previousState=currentState
	
	match currentState:
		ENEMYSTATE.IDLE:
			if is_hit:
				currentState=ENEMYSTATE.HURT
			if !player_in_range:
				currentState=ENEMYSTATE.WALK
			pass
		
		ENEMYSTATE.WALK:
			if player_in_range:
				currentState=ENEMYSTATE.ATTACK
			if is_hit:
				currentState=ENEMYSTATE.HURT
			pass
			
		ENEMYSTATE.ATTACK:
			if is_hit:
				currentState=ENEMYSTATE.HURT
			if !player_in_range:
				currentState=ENEMYSTATE.IDLE
			pass
			
		ENEMYSTATE.HURT:
			if !is_hit:
				currentState=ENEMYSTATE.IDLE
			if dead:
				currentState=ENEMYSTATE.DEAD
			pass
		
		ENEMYSTATE.DEAD:
			pass

func TakeDamage(damage):
	if !is_hit:
		skeleton_health-=damage
		is_hit=true
		AnimatedSprite.play("HIT")

func _on_AnimatedSprite_frame_changed():
	if AnimatedSprite.animation=="ATTACK" && AnimatedSprite.frame >= 7 && AnimatedSprite.frame <= 8:
		HitBox.disabled=false
		#print("HITBOX ACTIVATED")
		#return
	else:
		HitBox.disabled=true
		#print("HITBOX DEACTIVATED")


func _on_Area2D_body_entered(body):
	if body.has_method("TakeDamage"):
		print("damage")
		if body.name == "KinematicBody2D":
			if Global.lives == 1:
				get_tree().change_scene("res://Scene/GameOver.tscn")
			else:
				Global.lives = Global.lives - 1
				get_tree().change_scene("res://Scene/SceneMain.tscn")
	
	

func _on_DetectBoomerang_body_entered(body):
	if body.name == "shootBoomerang":
		print("shoot")
		
		$DetectBoomerang/AudioStreamPlayer.play()
		if skeleton_health == 1:
			$AnimatedSprite.play("DEAD")
			body.queue_free()
			queue_free()
		else:
			$AnimatedSprite.play("HIT")
			skeleton_health = skeleton_health - 1

