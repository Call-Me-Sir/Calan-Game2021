extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var friction = 0.19
export var acceleration = 0.15
var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	if Input.is_action_pressed("ui_right"):
		input_velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		input_velocity.y -= 1
	if Input.is_action_pressed("speedup"):
		speed = 400
		friction = 0.2
	if Input.is_action_just_released("speedup"):
		speed = 200
		friction = 0.19
	if Input.is_action_pressed("slowdown"):
		speed = 70
		friction = 0.16
	if Input.is_action_just_released("slowdown"):
		speed = 200
		friction = 0.19
	input_velocity = input_velocity.normalized() * speed

	# If there's input, accelerate to the input velocity
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
