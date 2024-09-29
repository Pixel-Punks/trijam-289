class_name  Card extends CharacterBody2D

@onready var area2D : Area2D = %Area2D
@onready var collision_shape : CollisionShape2D = %CollisionShape2D
var planet : Planet
var draggable : bool = false
var being_dragged : bool = true
var speed : float = 10000.0
var speed_dampen : float = 0
var distance_speed_dampen : float = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area2D.mouse_entered.connect(_on_mouse_enter)
	area2D.mouse_exited.connect(_on_mouse_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_handle_click()
	_move_if_dragged(delta)

func _on_mouse_enter() -> void :
	draggable = true

func _on_mouse_exit() -> void :
	draggable = false
	
func _handle_click() -> void :
	if GManager.planet_details_shown:
		return
	elif draggable && !GManager.isDragging && GManager.highest_grabbable_z_index <= z_index:
		if Input.is_action_just_pressed("left_click"):
			GManager.move_card_on_top(z_index)
			being_dragged = true
			GManager.isDragging = true
		elif Input.is_action_just_pressed("right_click"):
			GManager.planet_details_shown = true
			GManager.planet_for_details = self as Card
	elif !Input.is_action_pressed("left_click") && being_dragged:
		being_dragged = false
		GManager.isDragging = false
		
func _move_if_dragged(delta: float) -> void :
	if being_dragged:
		var direction = get_global_mouse_position() - position
		var speed_dampen = direction.length()
		if speed_dampen > 100:
			speed_dampen = 100
		move_and_collide(direction.normalized()*delta*(speed*(speed_dampen/distance_speed_dampen)))
		
