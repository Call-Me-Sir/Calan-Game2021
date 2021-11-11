extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in (Master.max_level):
		get_node("Level Select/LVLRows/LVL1-5/LVL" + str(i+1)).set_disabled(false)
	for i in (Master.max_level):
		get_node("Level Select/LVLRows/LVL6-10/LVL" + str(i+6)).set_disabled(false)
	for i in (Master.max_level):
		get_node("Level Select/LVLRows/LVL11-15/LVL" + str(i+11)).set_disabled(false)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://OptionsMenu.tscn")


func _on_LVLChanged_pressed(lvl):
	get_tree().change_scene("res://Levels/Level "+ str(lvl) + ".tscn")


func back_to_main_menu():
	get_tree().change_scene("res://Main Menu.tscn")
