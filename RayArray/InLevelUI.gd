extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var showing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$Label.text == get_parent() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("UI ShowHide") and showing == true:
		hide()
		showing = false
	elif Input.is_action_just_pressed("UI ShowHide") and showing == false:
		show()
		showing = true
