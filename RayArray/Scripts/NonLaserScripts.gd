extends StaticBody2D

var pickupable = false
var rotation_dir = 0
var mouse_in = false
var in_control_area
var scaled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Rotate with q and e
	if get_parent().name == "Playerspaceshipkinematic" or Input.is_mouse_button_pressed(BUTTON_LEFT) and in_control_area == true:
		rotation_dir = 0
		var rotation_speed = 1
		if Input.is_action_pressed("ItemLeft"):
			rotation_dir -= 1
		if Input.is_action_pressed("ItemRight"):
			rotation_dir += 1
		#Shift to speed up rotation, ctrl to slow down
		if Input.is_action_pressed("Speedup"):
			rotation_speed = 3
		elif Input.is_action_just_released("Speedup"):
			rotation_speed = 1
		elif Input.is_action_pressed("Slowdown"):
			rotation_speed = 0.15
		elif Input.is_action_just_released("Slowdown"):
			rotation_speed = 1
		rotation += rotation_dir * rotation_speed * delta

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

func _on_Mirror_mouse_entered():
	mouse_in = true
	print(mouse_in)


func _on_Mirror_mouse_exited():
	mouse_in = false
	print(mouse_in)
