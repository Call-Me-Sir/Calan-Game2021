extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
		get_tree().change_scene("res://Level 2.tscn")
