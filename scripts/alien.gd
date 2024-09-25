class_name Alien extends Node2D

var rng = RandomNumberGenerator.new()

var climate: String = ["hot", "cold", "tempered"].pick_random()
var is_climate_sensitive = rng.randi_range(0, 100) > 80	
var atmosphere: String = ["oxygen", "nitrogen", "sulphur"].pick_random()
var is_atmosphere_sensitive = rng.randi_range(0, 100) > 50
var radiation: bool = [true, false].pick_random()
var is_radiation_sensitive = rng.randi_range(0, 100) > 20
var acid_water: bool = [true, false].pick_random()
var is_acid_sensitive = rng.randi_range(0, 100) > 20
var eternal_war: bool = [true, false].pick_random()
var food: bool = [true, false].pick_random()
var air: String = ["dry", "wet"].pick_random()
var is_air_sensitive = rng.randi_range(0, 100) > 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
