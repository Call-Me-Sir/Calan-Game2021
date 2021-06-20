extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var friction = 0.19
export var acceleration = 0.15
var velocity = Vector2.ZERO
var max_ray_cast = 1000

onready var red_laser = preload("res://LaserExperiment.tscn")
onready var mirror = preload("res://Mirror.tscn")
onready var _animated_sprite = $SpaceshipThrust
onready var _animated_sprite2 = $SpaceshipThrust2
onready var _animated_sprite3 = $SpaceshipThrust3
onready var _animated_sprite4 = $SpaceshipThrust4

var world_optic = null
var lasers = 1

func set_speed(s,f):
	speed = s
	friction = f

#Mr Smith version of deploycheck
func reparent_object(object, pickup = true):
	var new = object.duplicate
	if pickup:
		add_child(new)
		object.queue_free()
	else:
		get_parent().add_child(new)
		object.queue_free()


func deploy_check():
	if Input.is_action_just_pressed("Deploy&Pickup"):
		if get_node("RedLaser"):
			world_optic = red_laser.instance()
			world_optic.global_position = $RedLaser.global_position
			world_optic.global_rotation = get_local_mouse_position().angle()
			world_optic.name = "RedLaser"
			get_parent().add_child(world_optic)
			remove_child($RedLaser)
			
		elif get_node("Mirror"):
			world_optic = mirror.instance()
			world_optic.global_position = $Mirror.global_position
			world_optic.global_rotation = $Mirror.global_rotation
			world_optic.name = "Mirror"
			get_parent().add_child(world_optic)
			remove_child($Mirror)
		#elif 
		

func thrust_animation():
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("slowdown"):
		_animated_sprite.play("Small Right")
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("Thrust Right")
		if Input.is_action_pressed("speedup"):
			_animated_sprite.play("Full Right")
	elif Input.is_action_just_released("ui_right"):
		_animated_sprite.play("Thrust Right", true)
	
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("slowdown"):
		_animated_sprite2.play("Small Right")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite2.play("Thrust Right")
		if Input.is_action_pressed("speedup"):
			_animated_sprite2.play("Full Right")
	elif Input.is_action_just_released("ui_left"):
		_animated_sprite2.play("Thrust Right", true)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("slowdown"):
		_animated_sprite3.play("Small Up")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite3.play("Thrust Up")
		if Input.is_action_pressed("speedup"):
			_animated_sprite3.play("Full Up")
	elif Input.is_action_just_released("ui_up"):
		_animated_sprite3.play("Thrust Up", true)
		
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("slowdown"):
		_animated_sprite4.play("Small Up")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite4.play("Thrust Up")
		if Input.is_action_pressed("speedup"):
			_animated_sprite4.play("Full Up")
	elif Input.is_action_just_released("ui_down"):
		_animated_sprite4.play("Thrust Up", true)

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
	#Call reparent object



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_PickupArea_area_entered(area):
	print(area.name) # Replace with function body.


func _on_PickupArea_area_exited(area):
	pass # Replace with function body.
