extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var showing = true
var selected = 1
onready var Item1Texture = $ShipOrClose/ItemsShip/Item1/TextureRect
onready var PlayerShip = get_parent().get_node("Playerspaceshipkinematic")
onready var Lasertexture = preload("res://.import/Red Laser V1-1.png (4).png-926671cf9f2b105118afd4faa867a0b9.stex")
onready var Mirrortexture = preload("res://.import/Game Mirror V1(Get back to this)-1.png.png-66b3108008df97c0f54193844ed7e215.stex")
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
	if PlayerShip.has_node("RedLaser"):
		Item1Texture.texture = Lasertexture
	elif PlayerShip.has_node("Mirror"):
		Item1Texture.texture = Mirrortexture
	#put additional contraptions here
	else:
		pass	
