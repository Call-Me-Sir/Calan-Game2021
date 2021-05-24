extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var friction = 0.19
export var acceleration = 0.15
var velocity = Vector2.ZERO
var max_ray_cast = 1000

onready var red_laser = preload("res://Red Laser Contraption.tscn")
onready var _animated_sprite = $SpaceshipThrust
var world_laser = null

func set_speed(s,f):
	speed = s
	friction = f

func deploy_check():
	if Input.is_action_just_pressed("Deploy&Pickup"):
		if world_laser == null:
			world_laser = red_laser.instance()
			world_laser.global_position = $"Red Laser Contraption".global_position
			world_laser.global_rotation = get_local_mouse_position().angle()
			get_parent().add_child(world_laser)
			remove_child($"Red Laser Contraption")
		else:
			pass 
		

func thrust_animation():
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("slowdown"):
		_animated_sprite.play("Small Right")
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("Thrust Right")
		if Input.is_action_pressed("speedup"):
			_animated_sprite.play("Full Right")
	elif Input.is_action_just_released("ui_right"):
		_animated_sprite.play("Thrust Right", true)
	

func _process(_delta):
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	input_velocity.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_velocity.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	if Input.is_action_pressed("speedup"):
		set_speed(400,0.2)
	elif Input.is_action_just_released("speedup"):
		set_speed(200,0.19)
	elif Input.is_action_pressed("slowdown"):
		set_speed(70,0.16)
	elif Input.is_action_just_released("slowdown"):
		set_speed(200,0.19)
	input_velocity = input_velocity.normalized() * speed
	thrust_animation()
	# If there's input, accelerate to the input velocity
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
	deploy_check()




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
