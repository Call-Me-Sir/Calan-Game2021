extends StaticBody2D


# Declare member variables here. Examples:
onready var ray = $RayCast2D
onready var line = $Line2D
onready var texture = $Texture
onready var debugray = $DebugRay
var pickupable = false
var mouse_in = false
var max_bounces = 10
var in_control_area
var rotation_dir = 0
var has_scaled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line.clear_points()
	line.add_point(Vector2.ZERO)
	ray.global_position = line.global_position
	#ray.cast_to sends raycast straight forward to determine next point on line.
	if get_parent().name == "Playerspaceshipkinematic" or get_parent().name == "Main Menu":# or Input.is_mouse_button_pressed(BUTTON_LEFT) (For debugging):
		#If on player, use mouse to rotate
		texture.rotation = get_local_mouse_position().angle()
		ray.cast_to = Vector2(1000,0).rotated(texture.rotation)
		#ray.cast_to = (get_global_mouse_position()-line.global_position).normalized()* 1000
		$CollisionShape2D.disabled = true
	elif in_control_area == true and Input.is_mouse_button_pressed(BUTTON_LEFT):
		#If in control area, use arrow keys
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
		#Keep facing the same way in player absence
		ray.cast_to = Vector2(1000,0).rotated(texture.rotation)
		#$CollisionShape2D.disabled = false
	var prev = null
	var bounces = 0
	ray.force_raycast_update()
	while true:
		#If ray does not collide with anything, stop at faraway point
		if not ray.is_colliding():
			var pt = ray.global_position + ray.cast_to
			line.add_point(line.to_local(pt))
			break
		var coll = ray.get_collider()
		var pt = ray.get_collision_point()
		#If ray collides with point, point is now part of line
		line.add_point(line.to_local(pt))
		#Only mirrors can bounce
		if not coll.is_in_group("Mirror"):
			break
		
		var normal = ray.get_collision_normal()
		debugray.global_position = pt
		debugray.cast_to = normal * 1000
		if normal == Vector2.ZERO:
			break
		if prev != null:
			prev.collision_mask = 3
			prev.collision_layer = 3
		prev = coll
		prev.collision_mask = 0
		prev.collision_layer = 0
		ray.global_position = pt
		#Lasers including this one bounce along normals
		ray.cast_to = ray.cast_to.bounce(normal)
		ray.force_raycast_update()
		
		bounces += 1
		if bounces >= max_bounces:
			break
	$RayCast2D/SensorCheck/EndParticles.rotation = ray.get_collision_normal().angle()
	if prev != null:
		prev.collision_mask = 3
		prev.collision_layer = 3
	#Places a small area at laser impact point, this is for checking if sensor is being hit by laser(Found in sensor code)
	$RayCast2D/SensorCheck.global_position = ray.get_collision_point()
	
#	if ray.is_colliding():
#		if ray.get_collider().name == "Sensor":
#			ray.get_collider().emit_signal("RayHit")
			


func _on_Area2D_area_entered(area):
	#Notes it the player is near obect
	if area.name == "PickupArea":
		pickupable = true
		print(pickupable)
	if area.name == "MouseArea":
		mouse_in = true
		print(mouse_in)
	if area.name == "ControlArea":
		in_control_area = true

func _on_Area2D_area_exited(area):
	#Notes if the player is no longer near the object
	if area.name == "PickupArea":
		pickupable = false
		print(pickupable)
	if area.name == "MouseArea":
		mouse_in = false
		print(mouse_in)
	if area.name == "ControlArea":
		in_control_area = false
