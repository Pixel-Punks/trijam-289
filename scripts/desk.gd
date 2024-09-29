extends Node2D

@onready var desk_area : Area2D = %DeskArea
@onready var desk_shape : CollisionShape2D = %DeskPolygon
@onready var alien_area : Area2D = %AlienArea
@onready var alien_shape : CollisionShape2D = %AlienPolygon
@onready var alien_base_postition : Vector2 = alien_area.position
@onready var min_pos : Vector2 = %ScreenEdgeLeft.position
@onready var max_pos : Vector2 = %ScreenEdgeRight.position
@onready var rocket_pos : Vector2 = %RocketLaunchEdge.position
@onready var planet_details : PlanetDetails = %PlanetDetails
@onready var rocket_launch_sound : AudioStreamPlayer = %RocketLaunchStreamPlayer
@onready var door_open_sound : AudioStreamPlayer = %DoorOpenStreamPlayer
@onready var door_close_sound : AudioStreamPlayer = %DoorCloseStreamPlayer

@export var alien_speed : float = 100

const card_offset = 10
var rocket_launch_played : bool = false
var card_in_area : Card = null
var oob_card : Card = null
var card_return_position : Vector2
var enter_room : bool = true
var exit_room : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	alien_area.position[0] = min_pos[0]
	alien_area.body_entered.connect(on_area_entered)
	alien_area.body_exited.connect(on_area_exited)
	desk_area.body_exited.connect(on_body_exited_desk)
	desk_area.body_entered.connect(on_body_entered_desk)
	var desk_rect : Rect2 = get_collision_rect(desk_shape)
	var first_card_x : float = desk_rect.size[0] / 2 - (card_offset/2)*GManager.cards.size()
	var card_y : float = desk_area.global_position[1] + desk_rect.size[1] / 3
	var i = 0
	for card in GManager.cards:
		add_child(card)
		card.position = Vector2(first_card_x+i*card_offset, card_y)
		card.z_index = i
		i = i + 1

func get_collision_rect(collision : CollisionShape2D) -> Rect2:
	return collision.shape.get_rect()

func _physics_process(delta: float) -> void:
	if GManager.planet_details_shown :
		planet_details.planet = GManager.planet_for_details.planet
		if Input.is_action_just_pressed("left_click"):
			GManager.planet_for_details = null
			GManager.planet_details_shown = false
	planet_details.visible = GManager.planet_for_details != null
	handle_alien_cycling(delta)
	handle_card_drop()

func on_area_exited(body : Node2D):
	if body is Card:
		card_in_area = null
		print_debug("Card exited")

func on_area_entered(body: Node2D) -> void:
	if body is Card:
		card_in_area = body as Card
		print_debug("Card entered")

func on_body_exited_desk(body: Node2D) -> void:
	if body is Card:
		oob_card = body as Card
		card_return_position = Vector2(oob_card.position[0], desk_area.position[1])
		print_debug("Card exited desk")

func on_body_entered_desk(body: Node2D) -> void:
	if body is Card && (body as Card) == oob_card:
		oob_card = null
		print_debug("Card reentered desk")

func handle_card_drop() -> void :
	if Input.is_action_just_released("left_click") :
		if card_in_area != null:
			GManager.compute_score(card_in_area.planet)
			card_in_area = null
			exit_room = true
		if oob_card != null:
			oob_card.position = card_return_position
			oob_card = null

func handle_alien_cycling(delta : float) -> void :
	if enter_room || exit_room :
		alien_area.monitoring = false
		if exit_room :
			alien_area.position[0] += 5 * alien_speed * delta
		else :
			alien_area.position[0] += alien_speed * delta
	else :
		alien_area.monitoring = true
	if enter_room && alien_area.position[0] > alien_base_postition[0]:
		enter_room = false
		alien_area.position[0] = alien_base_postition[0]
	if !rocket_launch_played && exit_room && alien_area.position[0] > rocket_pos[0]:
		rocket_launch_played = true
		rocket_launch_sound.play()
	if exit_room && alien_area.position[0] > max_pos[0]: 
		exit_room = false
		enter_room = true
		rocket_launch_played = false
		door_open_sound.play()
		door_close_sound.play()
		alien_area.position[0] = min_pos[0]
