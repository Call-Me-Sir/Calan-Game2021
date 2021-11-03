extends Node

var level = 1
onready var victory = get_node("Victory")
signal level_changed(level_name)

export (String) var  level_name = "level"
# Called when the node enters the scene tree for the first time.
func _ready():
	victory.connect("area_entered", self, "_on_Victory_area_entered")
	print(Master.current_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		pass
		get_tree().change_scene("res://OptionsMenu.tscn")


func _on_Victory_area_entered(area):
	emit_signal("level_changed", level_name)
#	print(area.name)
	if area.name == "PickupArea":
		if Master.current_level == Master.max_level:
			Master.max_level +=1
		Master.current_level += 1
		get_tree().change_scene("res://Levels/Level " + str(Master.current_level) + ".tscn")
		
	else:
		pass
