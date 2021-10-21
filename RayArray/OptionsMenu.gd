extends ColorRect

var can_change_key = false
var action_string
enum ACTIONS {ui_left, ui_right, ui_up, ui_down, Speedup, Slowdown, ItemLeft, ItemRight, DeployPickup, SelectRight, SelectLeft, UIShowHide}
onready var ui_up = get_node("Panel/ScrollContainer/VBoxContainer/ui_up")
func _ready():
	_set_keys()

#func _process(_delta):
#	_set_keys()
	
func _set_keys():
	for j in ACTIONS:
		get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
		else:
			get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_text("No Button!")
			




func change_key_ItemLeft():
	_mark_button("ItemLeft")

	
func _mark_button(string):
	can_change_key = true
	action_string = string
	for j in ACTIONS:
		if j != string:
			get_node("Panel/ScrollContainer/VBoxContainer/" + str(j) + "/Button").set_pressed(false)

func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false

func _change_key(new_key):
	#Delete key of pressed button
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	#Check if new key was assigned somewhere
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	#Add new Key
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()

func _on_Button_pressed():
	get_tree().change_scene("res://Main Menu.tscn")


func change_key_ItemRight():
	_mark_button("ItemRight")
