class_name PlanetDetails extends Node2D

@onready var climate_label : Label = %ClimateLabel
@onready var atmosphere_label : Label = %AtmosphereLabel
@onready var radiation_label : Label = %RadiationLabel
@onready var acid_water_label : Label = %AcidWaterLabel
@onready var eternal_war_label : Label = %EternalWarLabel
@onready var holo_up_sound : AudioStreamPlayer = %HoloUpStreamPlayer
@onready var food_label : Label = %FoodLabel
@onready var air_label : Label = %AirLabel
@onready var planet_sprites : Array[Sprite2D] = [%PlanetSprite1, %PlanetSprite2]
var planet : Planet
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	visibility_changed.connect(on_visibility_changed)


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

func on_visibility_changed():
	if rng.randi() % 2 == 0:
		planet_sprites[0].visible = true
		planet_sprites[1].visible = false
	else:
		planet_sprites[0].visible = false
		planet_sprites[1].visible = true
	if visible:
		holo_up_sound.play()
