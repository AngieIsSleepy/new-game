extends Control

@onready var button = $MarginContainer/关闭

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/电脑屏幕/电脑屏幕.tscn")
	
func _ready():
	$Sprite2D.set_process_input(false)
	button.pressed.connect(_on_button_pressed)
	button.self_modulate.a = 0  # 按钮透明但可点击
