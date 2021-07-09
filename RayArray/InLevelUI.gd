extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var showing = true
var Selected = 0
onready var Red_laser = preload("res://LaserExperiment.tscn")
onready var Mirror = preload("res://Mirror.tscn")
onready var Item1Texture = $ShipOrClose/ItemsShip/ShipItem1/Texture
onready var Item2Texture = $ShipOrClose/ItemsShip/ShipItem2/Texture
onready var Item3Texture = $ShipOrClose/ItemsShip/ShipItem3/Texture
onready var PlayerShip = get_parent().get_node("Playerspaceshipkinematic")
onready var Lasertexture = preload("res://Imported resources/Red Laser V1-1.png (4).png")
onready var Mirrortexture = preload("res://.import/Game Mirror V1(Get back to this)-1.png.png-66b3108008df97c0f54193844ed7e215.stex")
onready var Emptytexture = preload("res://.import/New Piskel-1.png (4).png-b40f08a0ef2110e008128c0b22a35f1f.stex")
onready var ShipTextures = [Item1Texture, Item2Texture, Item3Texture]
onready var SelectedTexture = ShipTextures[Selected]
var PlayerOptic1 = "RedLaser"
var PlayerOptic2 = "Empty"
var PlayerOptic3 = "Empty"
var PlayerOptics = [PlayerOptic1,PlayerOptic2,PlayerOptic3]
var CurrentOptic = PlayerOptics[Selected]
# Called when the node enters the scene tree for the first time.
func _ready():
	Item2Texture.texture = Emptytexture
	Item3Texture.texture = Emptytexture
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
		#CurrentOptic = "RedLaser"
		PlayerOptics[Selected] = "RedLaser"
		SelectedTexture.texture = Lasertexture
	elif PlayerShip.has_node("Mirror"):
		#CurrentOptic = "Mirror"
		PlayerOptics[Selected] = "RedLaser"
		SelectedTexture.texture = Mirrortexture
	#put additional contraptions here
	else:
		#CurrentOptic = "Mirror"
		PlayerOptics[Selected] = "Empty"
		SelectedTexture.texture = Emptytexture	
	if Input.is_action_just_pressed("SelectLeft"):
		print(Selected)
		if PlayerShip.has_node("RedLaser"):
			PlayerShip.get_node("RedLaser").queue_free()
		elif PlayerShip.has_node("Mirror"):
			PlayerShip.get_node("Mirror").queue_free()
		if Selected >=1:
			Selected -= 1
		if PlayerOptics[Selected] == "RedLaser":
			var r = Red_laser.instance()
			r.position.x = 0
			r.position.y = 0
			r.name = "RedLaser"
			PlayerShip.add_child(r)
		elif PlayerOptics[Selected] == "Mirror":
			PlayerShip.add_child(Mirror)
		elif PlayerOptics[Selected] == "Empty":
			pass
	elif Input.is_action_just_pressed("SelectRight"):
		print(Selected)
		if PlayerShip.has_node("RedLaser"):
			PlayerShip.get_node("RedLaser").queue_free()
		elif PlayerShip.has_node("Mirror"):
			PlayerShip.get_node("Mirror").queue_free()
		if Selected <=1:
			Selected += 1
		if PlayerOptics[Selected] == "RedLaser":
			var r = Red_laser.instance()
			r.position.x = 0
			r.position.y = 0
			r.name = "RedLaser"
			PlayerShip.add_child(r)
		elif PlayerOptics[Selected] == "Mirror":
			PlayerShip.add_child(Mirror)
		elif PlayerOptics[Selected] == "Empty":
			pass
	Selected = clamp(Selected,0,2)
	SelectedTexture = ShipTextures[Selected]

