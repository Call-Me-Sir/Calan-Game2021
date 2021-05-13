extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var friction = 0.19
export var acceleration = 0.15
var velocity = Vector2.ZERO
var max_ray_cast = 1000

onready var _animated_sprite = $SpaceshipThrust

onready var ray = $RayCast2D
onready var new_ray = preload("res://ReflectorCast.tscn")
var reflector_ray = null

func set_speed(s,f):
	speed = s
	friction = f

func thrust_animation():
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("slowdown"):
		_animated_sprite.play("Small Right")
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("Thrust Right")
		if Input.is_action_pressed("speedup"):
			_animated_sprite.play("Full Right")
	elif Input.is_action_just_released("ui_right"):
		_animated_sprite.play("Thrust Right", true)
	

func _physics_process(delta):
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
	rotate_ray(delta)
	check_ray_collision()

func rotate_ray(delta):
	var mouse_position = get_local_mouse_position()
	ray.cast_to = mouse_position.normalized() * max_ray_cast
	$RayCast2D/ContraptionSprite.rotation = mouse_position.angle()

func check_ray_collision():	
	if ray.is_colliding():		
		var new_ray_position = ray.get_collision_point()
		var new_ray_angle = ray.get_collision_normal()
		var optic_device = ray.get_collider_shape()
		print(optic_device)
		if ray.get_collider().is_in_group("Mirror"):
			if reflector_ray == null :
				reflector_ray = new_ray.instance()
				reflector_ray.global_position = new_ray_position
				get_tree().get_root().add_child(reflector_ray)
			else:			
				print(ray.cast_to)
				reflector_ray.global_position = new_ray_position
				var r = ray.cast_to.bounce(ray.get_collision_normal())
				reflector_ray.cast_to = r 
				#reflector_ray.rotation = ray.get_collision_normal() - ray.get_parent().rotation	
	else:
		if reflector_ray != null:
			reflector_ray.queue_free()
			reflector_ray = null




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
