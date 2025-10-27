extends Control

func _ready() -> void:
	$"..".visible = false

func game_over():
	get_tree().paused = true
	$"..".visible = true

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
