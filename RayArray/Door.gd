extends StaticBody2D
var open = false
onready var line = $Line2D
onready var Sensor = $Sensor/Polygon2D
signal laserfalse
var laserhitting = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#line.clear_points()
	#line.add_point($Sensor.position)
	#line.add_point(Vector2.ZERO) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#Opens door when laser hits
	if open == false and laserhitting >= 1:
		Sensor.color = Color(1,0,0)
		line.default_color = Color(1,1,1)
		$AnimationPlayer.play("DoorOpen")
		open = true


#func _on_Sensor_RayHit():
#	if open == false:
#		$AnimationPlayer.play("DoorOpen")
#		open = true
#	print("Hit!") # Replace with function body.
#
#	get_node("Sensor").lasercheck()
#
#
#func _on_Sensor_Laserfalse():
#	if open == true:
#		$AnimationPlayer.play_backwards("DoorOpen")
#		open = false
#		print("Closing")


func _on_Area2D_area_entered(area):
	
	if area.is_in_group("Laser") and laserhitting == 0:
		Sensor.color = Color(1,0,0)
		line.default_color = Color(1,0,0)
		laserhitting +=1
		if open == false:
			$AnimationPlayer.play("DoorOpen")
			open = true
	elif area.is_in_group("Laser") and laserhitting != 0:
		laserhitting += 1
	


func _on_Area2D_area_exited(area):
	if area.is_in_group("Laser") and laserhitting == 1:
		Sensor.color = Color(1,1,1)
		line.default_color = Color(1,1,1)
		laserhitting -= 1
		if open == true:
			$AnimationPlayer.play_backwards("DoorOpen")
			open = false
			#print("Closing")
	elif area.is_in_group("Laser") and laserhitting > 1:
		laserhitting -=1
