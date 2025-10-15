extends Control

@onready var start_button = $VBoxContainer/startButton
@onready var resume_button = $VBoxContainer/resumeButton
@onready var quit_button = $VBoxContainer/quitButton

var save_path = "user://save_game.save"

func _ready():
	# 检查存档是否存在，可能需要调整颜色
	if not FileAccess.file_exists(save_path):
		resume_button.disabled = true
	else:
		resume_button.disabled = false
		 


	start_button.pressed.connect(_on_start_pressed)
	resume_button.pressed.connect(_on_continue_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _on_start_pressed():
	# 测试是否可以跳转
	print("Starting test")
	get_tree().change_scene_to_file("res://scenes/world_test.tscn")


func _on_continue_pressed():
	if not FileAccess.file_exists(save_path):
		return
	print("Continuing game...")
	# 加载存档还不知道咋写，先跳转
	get_tree().change_scene_to_file("res://scenes/world_test.tscn")
	


func _on_quit_pressed():
	get_tree().quit()
