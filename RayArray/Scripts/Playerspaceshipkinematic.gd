extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var friction = 0.19
export var acceleration = 0.15
var velocity = Vector2.ZERO

onready var ray = $ContraptionSprite/RayCast2D
onready var new_ray = preload("res://ReflectorCast.tscn")
var reflector_ray = null

func set_speed(s,f):
	speed = s
	friction = f
	
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

	# If there's input, accelerate to the input velocity
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
	check_ray_collision()

func check_ray_collision():	
	if ray.is_colliding():		
		var new_ray_position = ray.get_collision_point()
		#var new_ray_angle = ray.get_collision_normal()
		if reflector_ray == null:
			reflector_ray = new_ray.instance()
			reflector_ray.global_position = new_ray_position
			get_tree().get_root().add_child(reflector_ray)
		else:			
			reflector_ray.global_position = new_ray_position
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
