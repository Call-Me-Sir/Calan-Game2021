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
onready var pickup_area = $PickupArea
onready var control_area = $ControlArea
onready var mouse_area = $MouseArea
onready var victory = get_parent().get_node("Victory")
#onready var Ship_Red_Laser = $RedLaser
#onready var Ship_Mirror = $Mirror

var mouse_object = null
var local_objects
var closest_object
var world_optic = null
var lasers = 1


func set_speed(s,f):
	speed = s
	friction = f


func reparent_object(yn):
	#Use areas to create an array of objects that  can be picked up
	local_objects = pickup_area.get_overlapping_areas()
	local_objects.erase(control_area)
	local_objects.erase(mouse_area)
	local_objects.erase(victory)
	if local_objects.empty():
		return
	closest_object = local_objects[0]
	#Find closest object as the object that will be picked up is the closest one
	for close_object in local_objects:
		if global_position.distance_to(close_object.global_position) < global_position.distance_to(closest_object.global_position):
			closest_object = close_object
	var object = closest_object.get_parent()
	#If pressing pickup object button, pick up object
	if yn == "yes":
		if object.is_in_group("Pickupable"):
			var new = object.duplicate()
			new.position.x = 0
			new.position.y = 0
			if object.is_in_group("Mirror"):
				new.name = "Mirror"
			elif object.is_in_group("Laser"):
				new.name = "RedLaser"
			add_child(new)
			object.queue_free()
	#If not pressed pickup button, scale object so player can see witch object will be picked up
	#Does not work yet
	elif yn == "no": #and object.has_scaled == false:
		object.scale = object.scale# * 1.5
		#object.has_scaled == true



func deploy_check():
	#How the spaceship places and picks up items
	if Input.is_action_just_pressed("DeployPickup"):
		if has_node("RedLaser"):
			#Creates duplicate of current item, makes child of world at spaceship location and deletes item child
			world_optic = red_laser.instance()
			world_optic.global_position = $RedLaser.global_position
			
			#world_optic.global_rotation = get_local_mouse_position().angle()
			
			get_parent().add_child(world_optic)
			world_optic.texture.rotation = get_local_mouse_position().angle()
			remove_child($RedLaser)
			return
		elif has_node("Mirror"):
			#Ditto for above. Need different code for different items
			world_optic = mirror.instance()
			world_optic.global_position = $Mirror.global_position
			world_optic.global_rotation = $Mirror.global_rotation
			world_optic.add_to_group("Mirror")
			get_parent().add_child(world_optic)
			remove_child($Mirror)
			return
		#Put more optical contraptions here
		else:
			reparent_object("yes")
	reparent_object("no")
		
#Doesn't do anything right now
func close_glow():
	local_objects = $PickupArea.get_overlapping_areas()
	if local_objects.empty():
		return
	closest_object = local_objects[0]
	for close_object in local_objects:
		if global_position.distance_to(close_object.global_position) < global_position.distance_to(closest_object.global_position):
			closest_object = close_object
	var object = closest_object.get_parent()
	
	#object.Texture.size.x = object.Texture.size.x * 1.1
	#object.Texture.size.y = object.Texture.size.y * 1.1
	#closest_object.get_parent().Light.show()

	#Input.is_action_just_pressed("Sp")

func thrust_animation():
	#Controls what animations play when the player moves. Mostly self explanatory
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("Slowdown"):
		_animated_sprite.play("Small Right")
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("Thrust Right")
		if Input.is_action_pressed("Speedup"):
			_animated_sprite.play("Full Right")
	#Reverses thrust up animation to create thrust down effect upon key release
	elif Input.is_action_just_released("ui_right"):
		_animated_sprite.play("Thrust Right", true)
	
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("Slowdown"):
		_animated_sprite2.play("Small Right")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite2.play("Thrust Right")
		if Input.is_action_pressed("Speedup"):
			_animated_sprite2.play("Full Right")
	elif Input.is_action_just_released("ui_left"):
		_animated_sprite2.play("Thrust Right", true)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("Slowdown"):
		_animated_sprite3.play("Small Up")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite3.play("Thrust Up")
		if Input.is_action_pressed("Speedup"):
			_animated_sprite3.play("Full Up")
	elif Input.is_action_just_released("ui_up"):
		_animated_sprite3.play("Thrust Up", true)
		
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("Slowdown"):
		_animated_sprite4.play("Small Up")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite4.play("Thrust Up")
		if Input.is_action_pressed("Speedup"):
			_animated_sprite4.play("Full Up")
	elif Input.is_action_just_released("ui_down"):
		_animated_sprite4.play("Thrust Up", true)

func _physics_process(_delta):
	#print(self.get_child(0))
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	input_velocity.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_velocity.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	#Shift speeds up player, Ctrl slows down player
	if Input.is_action_pressed("Speedup"):
		set_speed(400,0.2)
	elif Input.is_action_just_released("Speedup"):
		set_speed(200,0.19)
	elif Input.is_action_pressed("Slowdown"):
		set_speed(70,0.16)
	elif Input.is_action_just_released("Slowdown"):
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
	#close_glow()




# Called when the node enters the scene tree for the first time.
#func _ready():
#	if has_node("RedLaser"):
#		Ship_Red_Laser.add_collision_exception_with()
#	elif has_node("Mirror"):
#		Ship_Mirror




func _on_PickupArea_area_entered(area):
	pass #debugging


func _on_PickupArea_area_exited(_area):
	pass # Replace with function body.


# warning-ignore:unused_argument
func _on_MouseArea_area_entered(area):
	pass
	#mouse_object = area.get_parent()
	#print(mouse_object) # Replace with function body.



func _on_MouseArea_area_exited(_area):
	pass
	#mouse_object = null
	#print(mouse_object) # Replace with function body.
