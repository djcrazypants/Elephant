
extends KinematicBody2D

const SPEED = 30000
var velocity = Vector2()  # the player's movement vector
var last_direction = Vector2(-1,0) #default to facing left
var screensize  # size of the game window
var bullet
var bullet_velocity = Vector2()
var bullet_cooldown = 0


func _fixed_process(delta):
	
	
	#poll player input and set values accordingly
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		get_node("Aim Ray").rotation_deg = 135
		velocity.x = -1
		velocity.y = -1
		last_direction.x += -1
		last_direction.y += -1
	elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		get_node("Aim Ray").rotation_deg = 225
		velocity.x = 1
		velocity.y = -1
		last_direction.x = 1
		last_direction.y = -1
	elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		get_node("Aim Ray").rotation_deg = 45
		velocity.x = -1
		velocity.y = 1
		last_direction.x = -1
		last_direction.y = 1
	elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right"):
		get_node("Aim Ray").rotation_deg = 315
		velocity.y = 1
		velocity.x = 1
		last_direction.y = 1
		last_direction.x = 1
	elif Input.is_action_pressed("ui_up"):
		get_node("Aim Ray").rotation_deg = 180
		velocity.y = -1
		last_direction.y = -1
		last_direction.x = 0
	elif Input.is_action_pressed("ui_down"):
		get_node("Aim Ray").rotation_deg = 0
		velocity.y = 1
		last_direction.y = 1
		last_direction.x = 0
	elif Input.is_action_pressed("ui_right"):
		get_node("Aim Ray").rotation_deg = 270
		velocity.x = 1
		last_direction.y = 0
		last_direction.x = 1
	elif Input.is_action_pressed("ui_left"):
		get_node("Aim Ray").rotation_deg = 90
		velocity.x = -1
		last_direction.y = 0
		last_direction.x = -1
	else:
		velocity = Vector2(0,0) #do not adjust last_direction in this case
	
	
	
	if Input.is_action_pressed("ui_accept") and bullet_cooldown <= 0:
		
		var bullet = preload("res://Bullet.tscn").instance()
		bullet.add_collision_exception_with(self)
		get_parent().add_child( bullet ) #don't want bullet to move with me, so add it as child of parent
		bullet.position = self.position+(last_direction*5) #set origin to player so angle and collision will be correct
		bullet.velocity = last_direction
		
		
		bullet_cooldown = 10
	
	if bullet_cooldown > 0:
		bullet_cooldown += -1
		
	
	#velocity = 
	move_and_slide((velocity.normalized()* delta)*SPEED)
	
	
	