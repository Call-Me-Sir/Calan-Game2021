extends ColorRect


# Level buttons are disabled at game start. This code activates them as the player completes levels
func _ready():
	for i in (Master.max_level):
		if i <= 4:
			get_node("Level Select/LVLRows/LVL1-5/LVL" + str(i+1)).set_disabled(false)
		elif i > 4 and i < 10:
			get_node("Level Select/LVLRows/LVL6-10/LVL" + str(i+1)).set_disabled(false)
		elif i >= 10 and i < 16:
			get_node("Level Select/LVLRows/LVL11-15/LVL" + str(i+1)).set_disabled(false)
		elif i == 16:
			break
		


# Esc to options menu
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://OptionsMenu.tscn")

# When level button is pressed, change scene to said level
func _on_LVLChanged_pressed(lvl):
	get_tree().change_scene("res://Levels/Level "+ str(lvl) + ".tscn")

# Button back to main menu
func back_to_main_menu():
	get_tree().change_scene("res://Main Menu.tscn")
