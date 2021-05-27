extends StaticBody2D

var pickupable = false
var speedup = 3
var slowdown = 1/3
var rotation_dir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		rotation_speed = 0.25
	elif Input.is_action_just_released("slowdown"):
		rotation_speed = 1
	rotation += rotation_dir * rotation_speed * delta

func _on_Area2D_area_entered(area):
	var pickupable = true
	print(pickupable)



func _on_Area2D_area_exited(area):
	var pickupable = false
	print(pickupable)
