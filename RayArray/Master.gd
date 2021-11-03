extends Node

var current_level = 1
onready var level = get_parent().get_node("Level " + str(current_level))
var current_scene = null
var max_level = 1

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	print(current_scene)
	#current_scene.connect("level_changed", self, "handle_level_changed")
	print("123" + current_scene.name + str(current_level))
	
func _process(_delta):
	if Input.is_action_pressed("Debug Key"):
		var root = get_tree().get_root()
		current_scene = root.get_child(root.get_child_count() - 1)
		print(current_scene.name)

func handle_level_changed():
	pass
