extends StaticBody2D

signal RayHit
signal Laserfalse
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func lasercheck():
	if not self.is_connected("RayHit", get_node(".."), "_on_Sensor_Laserfalse"):
		#print(get_node(".."))
		emit_signal("Laserfalse")
		#print("Signal Laserfalse emmitting")
	else:
		#print("Ray still hitting")
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
