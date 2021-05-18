extends RayCast2D


onready var new_ray = load("res://ReflectorCast.tscn")
onready var ray = $ReflectorCast
onready var beam = $ReflectorCast/Beam
var reflector_ray = null
onready var beam_end = $ReflectorCast/End
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func check_ray_collision():	
	if ray.is_colliding():		
		var new_ray_position = ray.get_collision_point()
		var new_ray_angle = ray.get_collision_normal()
		var optic_device = ray.get_collider_shape()
		beam_end.global_position = ray.get_collision_point()
		print(optic_device)
		if ray.get_collider().is_in_group("Mirror"):
			$ReflectorCast/End/EndParticles.emitting = false
			$ReflectorCast/End/EndParticles.hide()
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
			$ReflectorCast/End/EndParticles.set_emitting(true)
			$ReflectorCast/End/EndParticles.show()
			var c = ray.get_collision_normal()
			var r = ray.cast_to.bounce(c)
			$ReflectorCast/End/EndParticles.rotation = c.angle() # + 0.5*r.angle()
			if reflector_ray != null:
				reflector_ray.queue_free()
				reflector_ray = null
	else:
		$ReflectorCast/End/EndParticles.emitting = false
		$ReflectorCast/End/EndParticles.hide()
		beam_end.global_position = ray.cast_to
		if reflector_ray != null:
			reflector_ray.queue_free()
			reflector_ray = null

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	beam.rotation = ray.cast_to.angle()
	beam.region_rect.end.x = beam_end.position.length()
	check_ray_collision()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
