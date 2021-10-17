extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LVL1_pressed():
	get_tree().change_scene("res://Level 1.tscn")


func _on_LVL2_pressed():
	get_tree().change_scene("res://Level 2.tscn")


func _on_LVL3_pressed():
	get_tree().change_scene("res://Level 3.tscn")


func _on_LVL4_pressed():
	get_tree().change_scene("res://Level 4.tscn")


func _on_LVL5_pressed():
	get_tree().change_scene("res://Level 5.tscn")
