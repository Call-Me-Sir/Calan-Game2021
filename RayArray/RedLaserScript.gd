extends Node2D


# Declare member variables here. Examples:
onready var beam = $RayCast2D/Beam
onready var beam_end = $RayCast2D/End
onready var ray = $RayCast2D
onready var new_ray = preload("res://ReflectorCast.tscn")
var reflector_ray = null
var max_ray_cast = 1000

func _process(delta):
	check_ray_collision()
	if get_tree().get_root().has_node("Playerspacehipkinematic") or Input.is_action_pressed("speedup"):
		ray_and_beam(delta)

func ray_and_beam(delta):
	var mouse_position = get_local_mouse_position()
	ray.cast_to = mouse_position.normalized() * max_ray_cast
	$RayCast2D/RedLaserSprite.rotation = mouse_position.angle()
	beam.rotation = ray.cast_to.angle()
	beam.region_rect.end.x = beam_end.position.length()

func check_ray_collision():	
	if ray.is_colliding():		
		var new_ray_position = ray.get_collision_point()
		var new_ray_angle = ray.get_collision_normal()
		var optic_device = ray.get_collider_shape()
		beam_end.global_position = ray.get_collision_point()
		print(optic_device)
		if ray.get_collider().is_in_group("Mirror"):
			$RayCast2D/End/EndParticles.emitting = false
			$RayCast2D/End/EndParticles.hide()
			if reflector_ray == null :
				reflector_ray = new_ray.instance()
				reflector_ray.global_position = new_ray_position
				#add_child(reflector_ray)
				
			else:			
				print(ray.cast_to)
				reflector_ray.global_position = new_ray_position
				var r = ray.cast_to.bounce(ray.get_collision_normal())
				reflector_ray.cast_to = r 
				
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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
