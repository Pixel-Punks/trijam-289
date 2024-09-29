class_name Planet extends Node2D


var climate: String = ["hot", "cold", "tempered"].pick_random()
var atmosphere: String = ["oxygen", "nitrogen", "sulphur"].pick_random()
var radiation: bool = [true, false].pick_random()
var acid_water: bool = [true, false].pick_random()
var eternal_war: bool = [true, false].pick_random()
var food: bool = [true, false].pick_random()
var air: String = ["dry", "wet"].pick_random()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
