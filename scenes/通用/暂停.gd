extends Control

func _ready() -> void:
	$"..".visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_game()

func pause_game():
	get_tree().paused = !get_tree().paused
	$"..".visible = !$"..".visible

func _on_button_pressed() -> void:
	pause_game()
