extends Node2D

@onready var desk_area : Area2D = %DeskArea
@onready var desk_shape : CollisionShape2D = %DeskPolygon
@onready var alien_area : Area2D = %AlienArea
@onready var alien_shape : CollisionShape2D = %AlienPolygon
const card_offset = 10
var card_in_area : Card = null
var oob_card : Card = null
var card_return_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if Input.is_action_just_released("left_click") :
		if card_in_area != null:
			GManager.compute_score(card_in_area.planet)
		if oob_card != null:
			oob_card.position = card_return_position
			oob_card = null
	
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
