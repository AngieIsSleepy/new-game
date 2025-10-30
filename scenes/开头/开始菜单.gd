extends Control
@onready var start_button = $HBoxContainer/startButton/start
@onready var resume_button = $HBoxContainer/resumeButton/resume
@onready var quit_button = $HBoxContainer/quitButton/quit
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/开头/开始菜单.tscn")


func _on_start_pressed():
	print("开始按钮被点击，开始游戏")
	get_tree().change_scene_to_file("res://scenes/电脑屏幕/桌面.tscn")

func _on_resume_pressed():
	if GameLoad.load_game() == 1:
		get_tree().change_scene_to_file("res://scenes/猫猫王国菜单/猫猫王国菜单.tscn")
	
func _on_quit_pressed():
	print("退出游戏")
	get_tree().quit()
