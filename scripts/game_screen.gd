extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello from screen")
	var gameManager = GameManager.new()
	add_child(gameManager)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
