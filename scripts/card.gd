extends CharacterBody2D

@onready var area2D : Area2D = %Area2D
var draggable : bool = false
var being_dragged : bool = true
var speed : float = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area2D.mouse_entered.connect(_on_mouse_enter)
	area2D.mouse_exited.connect(_on_mouse_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_click()
	move_if_dragged(delta)
	print(draggable)

func _on_mouse_enter() -> void:
	draggable = true

func _on_mouse_exit() -> void:
	draggable = false
	
func handle_click() -> void :
	if Input.is_action_just_pressed("left_click") && draggable :
		being_dragged = true
	elif !Input.is_action_pressed("left_click") && being_dragged:
		being_dragged = false
		
func move_if_dragged(delta: float) -> void :
	if being_dragged:
		position = get_viewport().get_mouse_position()
		
