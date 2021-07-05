extends StaticBody2D


# Declare member variables here. Examples:
onready var ray = $RayCast2D
onready var line = $Line2D
onready var texture = $Texture
var pickupable = false
var mouse_in = false
var max_bounces = 10
var in_control_area
var rotation_dir = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line.clear_points()
	line.add_point(Vector2.ZERO)
	ray.global_position = line.global_position
	if get_parent().name == "Playerspaceshipkinematic":# or Input.is_mouse_button_pressed(BUTTON_LEFT):
		texture.rotation = get_local_mouse_position().angle()
		ray.cast_to = Vector2(1000,0).rotated(texture.rotation)
		#ray.cast_to = (get_global_mouse_position()-line.global_position).normalized()* 1000
		$CollisionShape2D.disabled = true
	elif in_control_area == true:
		rotation_dir = 0
		var rotation_speed = 1
		if Input.is_action_pressed("Contraptionleft"):
			rotation_dir -= 1
		if Input.is_action_pressed("Contraptionright"):
			rotation_dir += 1
		if Input.is_action_pressed("speedup"):
			rotation_speed = 3
		elif Input.is_action_just_released("speedup"):
			rotation_speed = 1
		elif Input.is_action_pressed("slowdown"):
			rotation_speed = 0.15
		elif Input.is_action_just_released("slowdown"):
			rotation_speed = 1
		texture.rotation += rotation_dir * rotation_speed * delta
		ray.cast_to = Vector2(1000,0).rotated(texture.rotation)
	#	$CollisionShape2D.disabled = true
	else:
		ray.cast_to = Vector2(1000,0).rotated(texture.rotation)
		#$CollisionShape2D.disabled = false
	var prev = null
	var bounces = 0
	ray.force_raycast_update()
	while true:
		if not ray.is_colliding():
			var pt = ray.global_position + ray.cast_to
			line.add_point(line.to_local(pt))
			break
		var coll = ray.get_collider()
		var pt = ray.get_collision_point()
		
		line.add_point(line.to_local(pt))
		if not coll.is_in_group("Mirror"):
			break
		
		var normal = ray.get_collision_normal()
		if normal == Vector2.ZERO:
			break
		if prev != null:
			prev.collision_mask = 3
			prev.collision_layer = 3
		prev = coll
		prev.collision_mask = 0
		prev.collision_layer = 0
		ray.global_position = pt
		ray.cast_to = ray.cast_to.bounce(normal)
		ray.force_raycast_update()
		
		bounces += 1
		if bounces >= max_bounces:
			break
	$RayCast2D/SensorCheck/EndParticles.rotation = ray.get_collision_normal().angle()
	if prev != null:
		prev.collision_mask = 3
		prev.collision_layer = 3
		
	$RayCast2D/SensorCheck.global_position = ray.get_collision_point()
	
#	if ray.is_colliding():
#		if ray.get_collider().name == "Sensor":
#			ray.get_collider().emit_signal("RayHit")
			


func _on_Area2D_area_entered(area):
	if area.name == "PickupArea":
		pickupable = true
		print(pickupable)
	if area.name == "MouseArea":
		mouse_in = true
		print(mouse_in)
	if area.name == "ControlArea":
		in_control_area = true

func _on_Area2D_area_exited(area):
	if area.name == "PickupArea":
		pickupable = false
		print(pickupable)
	if area.name == "MouseArea":
		mouse_in = false
		print(mouse_in)
	if area.name == "ControlArea":
		in_control_area = false
