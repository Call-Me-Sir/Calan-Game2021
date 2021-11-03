extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in (Master.max_level):
		get_node("Level Select/LVLRows/LVL1-5/LVL" + str(i+1)).set_disabled(false)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LVL1_pressed():
	get_tree().change_scene("res://Levels/Level 1.tscn")


func _on_LVL2_pressed():
	get_tree().change_scene("res://Levels/Level 2.tscn")


func _on_LVL3_pressed():
	get_tree().change_scene("res://Levels/Level 3.tscn")


func _on_LVL4_pressed():
	get_tree().change_scene("res://Levels/Level 4.tscn")


func _on_LVL5_pressed():
	get_tree().change_scene("res://Levels/Level 5.tscn")
