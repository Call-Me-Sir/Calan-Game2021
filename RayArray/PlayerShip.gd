extends Area2D

var moving = false
export var SPEED = 50

var speedchange = 1


func _process(delta):
	moving = false
	
	if Input.is_action_pressed("ui_left"):
		move(-SPEED, 0, delta, true)
	if Input.is_action_pressed("ui_right"):
		move(SPEED, 0, delta, false)
	if Input.is_action_pressed("ui_up"):
		move(0 , -SPEED, delta)
	if Input.is_action_pressed("ui_down"):
		move(0 , SPEED, delta)
	#if moving == false:
	#	$AnimationPlayer.play("Idle")
	#else:
	#	$AnimationPlayer.play("Run")
	pass

func move(xspeed, yspeed, delta, flip= null):
	if Input.is_key_pressed(KEY_SHIFT):
		speedchange = 0.2
	elif Input.is_key_pressed(KEY_CONTROL):
		speedchange = 5
	else:
		speedchange = 1
	position.x += xspeed * delta * speedchange
	position.y += yspeed * delta * speedchange
	moving = true
	if flip == null:
		pass
	else:
		$Sprite.flip_h = flip

func _ready():
	pass
