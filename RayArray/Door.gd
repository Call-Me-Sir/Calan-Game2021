extends StaticBody2D
var open = false
onready var line = $Line2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	line.clear_points()
	line.add_point(Vector2.ZERO)
	
	line.add_point($Polygon2D.global_position) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if not _on_sensor_RayHit():
		#open == false
		#$AnimationPlayer.play_backwards("DoorOpen")


func _on_Sensor_RayHit():
	if open == false:
		$AnimationPlayer.play("DoorOpen")
		open = true
	print("Hit!") # Replace with function body.
	
	
