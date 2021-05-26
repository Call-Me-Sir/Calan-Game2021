extends StaticBody2D


# Declare member variables here. Examples:
onready var beam = $RayCast2D/Beam
onready var beam_end = $RayCast2D/End
onready var ray = $RayCast2D
onready var new_ray = preload("res://ReflectorCast.tscn")
var reflector_ray = null
var max_ray_cast = 2000

func deploy_check():
	if Input.is_action_just_pressed("Deploy&Pickup"):
		if get_parent().name == "Playerspaceshipkinematic":
			pass

func _physics_process(_delta):
	beam.region_rect.end.x = beam_end.position.length()
	deploy_check()
	check_ray_collision()
	if get_parent().name == "Playerspaceshipkinematic":
		ray_and_beam(get_local_mouse_position())

func ray_and_beam(mouse_position = Vector2.RIGHT*max_ray_cast):#Turns on laser by default
	
	ray.cast_to = mouse_position.normalized() * max_ray_cast
	$RayCast2D/RedLaserSprite.rotation = mouse_position.angle()
	$CollisionShape2D.rotation = mouse_position.angle()
	beam.rotation = ray.cast_to.angle()

func check_ray_collision():	
	if ray.is_colliding():		
		#Variables that specify the characteristics of new reflected or refracted rays
		var new_ray_position = ray.get_collision_point()
		var new_ray_angle = ray.get_collision_normal()
		beam_end.global_position = ray.get_collision_point()
		#If object is mirror, reflect by creating new ray
		if ray.get_collider().is_in_group("Mirror"):
			$RayCast2D/End/EndParticles.emitting = false
			$RayCast2D/End/EndParticles.hide()
			#Create reflect ray if none already exists
			if reflector_ray == null :
				reflector_ray = new_ray.instance()
				reflector_ray.global_position = new_ray_position
				add_child(reflector_ray)
			#If ray already exists, move the ray depending on the parent ray
			else:			
				print(ray.cast_to)
				reflector_ray.global_position = new_ray_position
				var r = ray.cast_to.bounce(new_ray_angle)
				reflector_ray.cast_to = r 
				
#If hitting opaque objects such as a wall, no new rays are made, 
#start emmitting particles and delete reflected/refracted children rays
		else:
			$RayCast2D/End/EndParticles.set_emitting(true)
			$RayCast2D/End/EndParticles.show()
			var c = ray.get_collision_normal()
			var b = ray.cast_to.bounce(c)
			$RayCast2D/End/EndParticles.rotation = c.angle()# + 0.5*b.angle()
			if reflector_ray != null:
				reflector_ray.queue_free()
				reflector_ray = null
	else:
		$RayCast2D/End/EndParticles.emitting = false
		$RayCast2D/End/EndParticles.hide()
		beam_end.global_position = ray.cast_to
		if reflector_ray != null:
			reflector_ray.queue_free()
			reflector_ray = null
# Called when the node enters the scene tree for the first time.
func _ready():
	ray_and_beam()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
