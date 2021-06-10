extends KinematicBody2D

const ACCELERATION = 70
const MAX_SPEED = 300
const JUMP_H = -650
const UP = Vector2(0, -1)
const GRAVITY = 40

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

func _physics_process(delta):
	#apply gravity to the player
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = true
		animationPlayer.play("walk")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		animationPlayer.play("walk")
		sprite.flip_h = false
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		animationPlayer.play("idle")
		friction = true
	
	if is_on_floor():
		
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_H
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
		else:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.01)
		
	motion = move_and_slide(motion, UP)
	



