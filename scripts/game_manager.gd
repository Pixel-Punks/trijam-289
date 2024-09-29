class_name GameManager extends Node

@export var max_bad_conditions = 3
var highest_grabbable_z_index = 0
var isDragging: bool = false
var cardScene : PackedScene = preload("res://scenes/card.tscn")
var aliens : Array[Alien] = []
var cards : Array[Card] = []
var planets : Array[Planet] = []
var score: int = 0
var alien: Alien
var current_traveler: int = 0
var dialogManager = DialogManager.new()
var alien_text: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	print("GM")
	for i in range(10):
		var alien : Alien = Alien.new()
		var planet : Planet = Planet.new()
		var card : Card = cardScene.instantiate()
		card.planet = planet
		aliens.append(alien)
		planets.append(planet)
		cards.append(card)
	
	alien = aliens[current_traveler]


func compute_score(planet: Planet):
	var bad_conditions = 0
	planets.append(Planet.new())
	alien = aliens[current_traveler]
	
	var died = false
	if (alien.is_acid_sensitive):
		if (planet.acid_water):
			bad_conditions+=1
	
	if (alien.is_air_sensitive):
		if (planet.atmosphere != alien.atmosphere):
			bad_conditions+=1
	
	if (alien.is_atmosphere_sensitive):
		if (planet.atmosphere != alien.atmosphere):
			bad_conditions+=1
	
	if (alien.is_climate_sensitive):
		if (planet.atmosphere != alien.atmosphere):
			bad_conditions+=1
	
	if (alien.is_radiation_sensitive):
		if (planet.radiation):
			bad_conditions+=1
	
	if (bad_conditions > max_bad_conditions):
		score -= 20
		print_debug("Alien died")
	else:
		score += 50
		print_debug("Alien survived")
	
	if (!aliens.is_empty()):
		current_traveler += 1
		alien = aliens[current_traveler]

	print_debug("Cycled to next alien")


func ask_question(id: int):
	if (id == 1):
		if (alien.is_climate_sensitive):
			alien_text.text = "I'm not climate sensitive"
		else:
			alien_text.text = "I support " + alien.climate + " climate"


func _physics_process(delta: float) -> void:
	highest_grabbable_z_index = 0
	for card in GManager.cards:
		if card.draggable:
			highest_grabbable_z_index = max(highest_grabbable_z_index, card.z_index)

func move_card_on_top(current_z_index:int) -> void:
	var current_card
	for card in cards:
		if card.z_index == current_z_index:
			current_card = card
		if card.z_index > current_z_index:
			card.z_index -= 1
	current_card.z_index = cards.size() - 1
