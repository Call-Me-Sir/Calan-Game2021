extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mousepositoion

func _process(delta):
	mousepositoion = get_local_mouse_position()
	
	rotation += mousepositoion.angle() * 0.2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
