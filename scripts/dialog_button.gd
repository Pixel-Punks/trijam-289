class_name DialogButton extends Node2D

@export var dialogs: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	for dialog in dialogs:
		var button = Button.new()
		button.text = dialog
		button.position += Vector2(0, 40 * i)
		add_child(button)
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
