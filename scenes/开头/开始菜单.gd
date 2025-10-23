extends Control
@onready var start_button = $HBoxContainer/startButton/TextureButton
@onready var resume_button = $HBoxContainer/resumeButton/TextureButton
@onready var quit_button = $HBoxContainer/quitButton/TextureButton
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/开头/开始菜单.tscn")

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	resume_button.disabled = true

func _on_start_pressed():
	print("开始按钮被点击，开始游戏")
	get_tree().change_scene_to_file("res://scenes/电脑屏幕/电脑屏幕.tscn")

func _on_resume_pressed():
	print("继续游戏")
	# 啥也没有
	get_tree().change_scene_to_file("res://scenes/电脑屏幕/电脑屏幕.tscn")
	
func _on_quit_pressed():
	print("退出游戏")
	get_tree().quit()
