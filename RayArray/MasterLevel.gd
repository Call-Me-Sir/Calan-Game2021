extends Node

onready var current_level = $Level1
onready var level_num = 1

func _ready():
	pass
	#current_level.connect("level_changed", self, "handle_level_changed")
	
#func handle_level_changed(current_level_name: String):
#	var next_level
#	var next_level_name: String
#
#	#match current_level_name:
#	#	"Level " + str(level_num):
#	#		next_level_name = "Level 2"
#	#	_:
#	#		return
#
#
#
#	next_level = load("res://Levels/Level " + str(level_num) + ".tscn").instance()
#	add_child(next_level)
#	next_level.connect("level_changed", self, "handle_level_changed")
#	current_level.queue_free()
#	current_level = next_level
#	level_num += 1
