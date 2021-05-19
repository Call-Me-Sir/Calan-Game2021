extends RayCast2D


onready var new_ray = load("res://ReflectorCast.tscn")

onready var beam = $Beam
var reflector_ray = null
onready var beam_end = $End
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func check_ray_collision():	
	if is_colliding():
		var new_ray_position = get_collision_point()
		var new_ray_angle = get_collision_normal()
		var optic_device = get_collider_shape()
		beam_end.global_position = get_collision_point()
		print(optic_device)
		if get_collider().is_in_group("Mirror"):
			$End/EndParticles.emitting = false
			$End/EndParticles.hide()
			if reflector_ray == null :
				reflector_ray = new_ray.instance()
				reflector_ray.global_position = new_ray_position
				get_tree().get_root().add_child(reflector_ray)
			else:			
				print(cast_to)
				reflector_ray.global_position = new_ray_position
				var r = cast_to.bounce(get_collision_normal())
				reflector_ray.cast_to = r 
				#reflector_ray.rotation = ray.get_collision_normal() - ray.get_parent().rotation
		else:
			$End/EndParticles.set_emitting(true)
			$End/EndParticles.show()
			var c = get_collision_normal()
			var r = cast_to.bounce(c)
			$End/EndParticles.rotation = c.angle() # + 0.5*r.angle()
			if reflector_ray != null:
				reflector_ray.queue_free()
				reflector_ray = null
	else:
		$End/EndParticles.emitting = false
		$End/EndParticles.hide()
		beam_end.global_position = cast_to
		if reflector_ray != null:
			reflector_ray.queue_free()
			reflector_ray = null

# Called when the node enters the scene tree for the first time.
func _process(delta):
	beam.rotation = cast_to.angle()
	beam.region_rect.end.x = beam_end.position.length()
	check_ray_collision()
	ray_casting(delta)

func ray_casting(delta):
	#ray.cast_to = 
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
