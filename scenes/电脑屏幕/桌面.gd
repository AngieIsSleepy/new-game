extends Node2D

@onready var game_button = $MarginContainer/cat_kindom_icon_button
@onready var note_button = $MarginContainer2/Button
@onready var close_button = $MarginContainer3/关闭
@onready var note = $Note

var current_slide := 0
var total_slides := 3
var animation_playing := false
var player_name = ""
var log_checked = false

func _ready():
	note_button.self_modulate.a = 0
	game_button.self_modulate.a = 0
	close_button.self_modulate.a = 0
	game_button.disabled = false
	note_button.disabled = false
	close_button.disabled = true
	$laptop_background.set_process_input(false)
	note.visible = false

func _on_cat_kindom_icon_button_pressed():
	if log_checked == false:
		Dialogic.start("在桌面点击游戏")
	else:
		get_tree().change_scene_to_file("res://scenes/猫猫王国菜单/猫猫王国菜单.tscn")

func _wait_for_left_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("left_click"):
			return

func _on_button_pressed() -> void:
	log_checked = true
	Dialogic.start("在桌面点击日志")
	note.visible = true
	close_button.self_modulate.a = 1
	close_button.disabled = false
	note_button.disabled = true
	game_button.disabled = true
	


func _on_关闭_pressed() -> void:
	note.visible = false
	close_button.self_modulate.a = 0
	close_button.disabled = true
	game_button.disabled = false
	note_button.disabled = false
	
