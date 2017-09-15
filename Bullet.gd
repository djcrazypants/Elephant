extends KinematicBody2D

var velocity = Vector2(0,0)
const speed = 2000

func _fixed_process(delta):
	move((velocity.normalized()* delta)*speed)

	 