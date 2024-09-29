extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogButton = get_node("DialogButton")
	dialogButton.add_dialogs(GManager.dialogManager.dialogs)
	get_node("Label").text = "Hello"
	GManager.alien_text = get_node("Label")
	GManager.question_buttons = dialogButton.buttons

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
