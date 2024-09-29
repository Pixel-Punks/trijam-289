extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lblscore.text = str(GManager.score)
	if (GManager.aliens_that_died >= 5):
		$lblfired.text = "FIRED"
	else:
		$lblfired.text = "FIREN'T"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
	
