class_name PlanetDetails extends Node2D

@onready var climate_label : Label = %ClimateLabel
@onready var atmosphere_label : Label = %AtmosphereLabel
@onready var radiation_label : Label = %RadiationLabel
@onready var acid_water_label : Label = %AcidWaterLabel
@onready var eternal_war_label : Label = %EternalWarLabel
@onready var food_label : Label = %FoodLabel
@onready var air_label : Label = %AirLabel
var planet : Planet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if planet == null:
		return
	
	climate_label.text = "Climate : " + planet.climate
	atmosphere_label.text = "Atmosphere : " + planet.atmosphere 
	radiation_label.text = "Planet is "
	if !planet.radiation:
		radiation_label.text += " not "
	radiation_label.text += "radioactive"
	
	acid_water_label.text = "Water is "
	if planet.acid_water:
		acid_water_label.text += "acid"
	else:
		acid_water_label.text += "normal"
		
	eternal_war_label.text = "Planet is "
	if planet.eternal_war:
		eternal_war_label.text += "constantly at war"
	else:
		eternal_war_label.text += "peaceful"
	
	food_label.text = "There is "
	if !planet.food:
		food_label.text += " no "
	food_label.text += "food on the planet"
	
	air_label.text = "Air is " + planet.air
