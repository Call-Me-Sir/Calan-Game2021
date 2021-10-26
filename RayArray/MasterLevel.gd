extends Node


func _ready():
	$Level1.connect("level_changed", self, "handle_level_changed")
	
func handle_level_changed(current_level_name: String):
	pass
