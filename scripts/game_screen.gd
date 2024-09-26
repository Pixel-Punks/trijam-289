extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var gameManager = GameManager.new()
	add_child(gameManager)
	var dialogButton = DialogButton.new()
	dialogButton.dialogs = gameManager.dialogManager.dialogs
	add_child(dialogButton)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
