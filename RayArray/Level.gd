extends Node

var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Victory_area_entered(area):
	print(area.name)
	if area.name == "PickupArea":
		print("Win")
		level += 1
		print(level)
		get_tree().change_scene("res://Level " + str(level) + ".tscn")
	else:
		pass
