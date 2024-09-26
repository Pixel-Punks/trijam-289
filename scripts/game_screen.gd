extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogButton = DialogButton.new()
	dialogButton.dialogs = GManager.dialogManager.dialogs
	add_child(dialogButton)
	print("hello from screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
