class_name GameManager extends Node

var isDragging: bool = false
var aliens = []
var planets = []
var score: int = 0
var alien: Alien
var current_traveler: int = 0
var dialogManager = DialogManager.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var alien = Alien. new()
		aliens.append(alien)
		planets.append(Planet.new())
	
	alien = aliens[current_traveler]


func compute_score(planet: Planet):
	var died = false
	if (alien.is_acid_sensitive):
		if (planet.acid_water):
			died = true
	
	if (alien.is_air_sensitive):
		if (planet.atmosphere != alien.atmosphere):
			died = true
	
	if (alien.is_atmosphere_sensitive):
		if (planet.atmosphere != alien.atmosphere):
			died = true
	
	if (alien.is_climate_sensitive):
		if (planet.atmosphere != alien.atmosphere):
			died = true
	
	if (alien.is_radiation_sensitive):
		if (planet.radiation):
			died = true
	
	if (died):
		score -= 20
	else:
		score += 50
	
	if (!aliens.is_empty()):
		current_traveler += 1
		alien = aliens[current_traveler]
