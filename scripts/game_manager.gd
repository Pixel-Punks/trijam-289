class_name GameManager extends Node

@export var max_bad_conditions = 1
var highest_grabbable_z_index = 0
var planet_details_shown : bool = false
var planet_for_details : Card
var isDragging : bool = false
var cardScene : PackedScene = preload("res://scenes/card.tscn")
var aliens : Array[Alien] = []
var cards : Array[Card] = []
var planets : Array[Planet] = []
var score: int = 0
var alien: Alien
var current_traveler: int = 0
var dialogManager = DialogManager.new()
var alien_text: Label
var question_left = 4
var question_buttons: Array[Button]
var audio: AudioStreamPlayer
var aliens_that_died = 0
var blblbls = [
	preload("res://assets/sounds/blblbl/blblbl1.wav"),
	preload("res://assets/sounds/blblbl/blblbl2.wav"),
	preload("res://assets/sounds/blblbl/blblbl3.wav"),
	preload("res://assets/sounds/blblbl/blblbl4.wav"),
	preload("res://assets/sounds/blblbl/blblbl5.wav"),
	preload("res://assets/sounds/blblbl/blblbl6.wav"),
	preload("res://assets/sounds/blblbl/blblbl7.wav"),
	preload("res://assets/sounds/blblbl/blblbl8.wav"),
	preload("res://assets/sounds/blblbl/blblbl9.wav"),
	preload("res://assets/sounds/blblbl/blblbl10.wav"),
	preload("res://assets/sounds/blblbl/blblbl11.wav"),
	preload("res://assets/sounds/blblbl/blblbl12.wav"),
	preload("res://assets/sounds/blblbl/blblbl13.wav"),
	preload("res://assets/sounds/blblbl/blblbl14.wav"),
	preload("res://assets/sounds/blblbl/blblbl15.wav"),
	preload("res://assets/sounds/blblbl/blblbl16.wav"),
	preload("res://assets/sounds/blblbl/blblbl17.wav"),
	preload("res://assets/sounds/blblbl/blblbl18.wav"),
	preload("res://assets/sounds/blblbl/blblbl19.wav"),
	preload("res://assets/sounds/blblbl/blblbl20.wav"),
	preload("res://assets/sounds/blblbl/blblbl21.wav"),
	preload("res://assets/sounds/blblbl/blblbl22.wav"),
	preload("res://assets/sounds/blblbl/blblbl23.wav"),
	preload("res://assets/sounds/blblbl/blblbl24.wav"),
	preload("res://assets/sounds/blblbl/blblbl25.wav"),
	preload("res://assets/sounds/blblbl/blblbl26.wav")
]
var hmmm = [
	preload("res://assets/sounds/hmmm/hmmmm1.wav"),
	preload("res://assets/sounds/hmmm/hmmmm2.wav"),
	preload("res://assets/sounds/hmmm/hmmmm3.wav"),
	preload("res://assets/sounds/hmmm/hmmmm4.wav"),
	preload("res://assets/sounds/hmmm/hmmmm5.wav"),
	preload("res://assets/sounds/hmmm/hmmmm6.wav"),
	preload("res://assets/sounds/hmmm/hmmmm7.wav"),
	preload("res://assets/sounds/hmmm/hmmmm8.wav"),
	preload("res://assets/sounds/hmmm/hmmmm9.wav"),
	preload("res://assets/sounds/hmmm/hmmmm10.wav"),
	preload("res://assets/sounds/hmmm/hmmmm11.wav"),
	preload("res://assets/sounds/hmmm/hmmmm12.wav"),
	preload("res://assets/sounds/hmmm/hmmmm13.wav"),
	preload("res://assets/sounds/hmmm/hmmmm14.wav"),
	preload("res://assets/sounds/hmmm/hmmmm15.wav")
]

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
	audio.stream = hmmm.pick_random()
	audio.play()
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
		score -= 75
		aliens_that_died += 1
		print_debug("Alien died")
	else:
		score += 50
		print_debug("Alien survived")
		
	if (!alien.is_climate_sensitive):
		if (planet.climate == alien.climate):
			score += 25
	
	if (!alien.is_atmosphere_sensitive):
		if (planet.atmosphere == alien.atmosphere):
			score += 25
	
	if (!alien.is_air_sensitive):
		if (planet.air == alien.air):
			score += 25
			
	if (!aliens.is_empty()):
		current_traveler += 1
		alien = aliens[current_traveler]
	
	alien_text.text = "Hello"
	question_left = 4
	for button in question_buttons:
		button.disabled = false
	print_debug("Cycled to next alien")


func ask_question(id: int):
	audio.stream = blblbls.pick_random()
	audio.play()
	if (id == 1):
		if (!alien.is_climate_sensitive):
			alien_text.text = "I'm not climate sensitive"
		else:
			alien_text.text = "I support " + alien.climate + " climate"
	if (id == 2):
		if (!alien.is_atmosphere_sensitive):
			alien_text.text = "I'm not atmosphere senitive"
		else:
			alien_text.text = "I support " + alien.atmosphere + " atmosphere"
	if (id == 3):
		if (!alien.is_radiation_sensitive):
			alien_text.text = "I don't support radiation"
		else:
			alien_text.text = "I support radiation"
	if (id == 4):
		if (!alien.is_acid_sensitive):
			alien_text.text = "I resist to acid"
		else:
			alien_text.text = "I don't resist to acid"
	if (id == 5):
		if (!alien.is_air_sensitive):
			alien_text.text = "I'm not air sensitive"
		else:
			alien_text.text = "I support " + alien.air + " air"
	if (id == 6):
		if (!alien.food):
			alien_text.text = "I don't need food"
		else:
			alien_text.text = "I need food to survive"
	if (id == 7):
		alien_text.text = "I prefer " + alien.climate + " climate"
	if (id == 8):
		alien_text.text = "I prefer " + alien.atmosphere + " atmosphere"
	if (id == 9):
		alien_text.text = "I prefer " + alien.air + " air"
	 
	question_left -= 1
	return question_left 


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
