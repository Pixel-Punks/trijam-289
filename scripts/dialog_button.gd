class_name DialogButton extends Node2D

@export var dialogs: Array[String]

var buttons: Array[Button] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func add_dialogs(dialogs):
	var i = 0
	for dialog in dialogs:
		var button = Button.new()
		button.text = str(i+1) + ". " + dialog
		button.position += Vector2(0, 40 * i)
		button.pressed.connect(Callable(self, "_on_button_pressed").bind(button))
		add_child(button)
		buttons.append(button)
		i += 1


func _on_button_pressed(b: Button):
	var question_left = GManager.ask_question(int(b.text[0]))
	b.disabled = true
	
	if (question_left == 0):
		for button in buttons:
			button.disabled = true
