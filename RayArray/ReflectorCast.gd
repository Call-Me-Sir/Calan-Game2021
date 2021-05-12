extends RayCast2D


onready var new_ray = load("res://ReflectorCast.tscn")
var reflector_ray = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func check_ray_collision():	
	if is_colliding():		
		var new_ray_position = get_collision_point()
		var new_ray_angle = get_collision_normal()
		if reflector_ray == null:
			reflector_ray = new_ray.instance()
			reflector_ray.global_position = new_ray_position
			get_tree().get_root().add_child(reflector_ray)
		else:			

			reflector_ray.global_position = new_ray_position
			var r = cast_to.bounce(get_collision_normal())
			reflector_ray.cast_to = r 
			#reflector_ray.rotation = ray.get_collision_normal() - ray.get_parent().rotation	
	else:
		if reflector_ray != null:
			reflector_ray.queue_free()
			reflector_ray = null

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	#check_ray_collision()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
