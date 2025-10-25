extends Node2D

@onready var game_button = $MarginContainer/cat_kindom_icon_button
@onready var note_button = $MarginContainer2/Button
@onready var close_button = $MarginContainer3/关闭
#@onready var ppt = [$ppt1, $ppt2, $ppt3]
@onready var note = $Note
#@onready var black_screen: ColorRect = $Black

var current_slide := 0
var total_slides := 3
var animation_playing := false
var player_name = ""
var log_checked = false

func _ready():
	game_button.disabled = false
	note_button.disabled = false
	close_button.disabled = true
#	black_screen.visible = false
	close_button.disabled = true
	$laptop_background.set_process_input(false)
	note.self_modulate = Color(1,1,1,0)
	
	game_button.pressed.connect(_on_cat_kindom_icon_button_pressed)
	game_button.self_modulate.a = 0  # 按钮透明但可点击
	
	note_button.pressed.connect(_on_button_pressed)
	note_button.self_modulate.a = 0
	
	close_button.pressed.connect(_on_关闭_pressed)
	close_button.self_modulate.a = 0
	
	

#	for i in range(ppt.size()):
#		ppt[i].visible = false
#		ppt[i].z_index = 10
		
func _on_cat_kindom_icon_button_pressed():
	if log_checked == false:
		Dialogic.start("在桌面点击游戏")
	else:
		get_tree().change_scene_to_file("res://scenes/猫猫王国菜单/猫猫王国菜单.tscn")
#	game_button.disabled = true
#	note_button.disabled = true
#	close_button.disabled = true
	#animation_playing = true
	#print("开始播放幻灯片动画")
	#await _play_pptshow()
	


# 播放ppt
#func _play_pptshow():
#	while current_slide < total_slides:
#		# 隐藏上一个
#		if current_slide > 0:
#			ppt[current_slide - 1].visible = false
#		ppt[current_slide].visible = true
#		print("显示第 %d 张 PPT" % (current_slide + 1))
#		
#		current_slide += 1
#		await get_tree().create_timer(2.0).timeout
#
#	print("放完了")
#	await _wait_for_left_click()
#	black_screen.visible = true
#	ppt[2].visible = false
#	Dialogic.start("name")
#	await Dialogic.timeline_ended
#	get_tree().change_scene_to_file("res://scenes/初见/first_meet.tscn")

func _wait_for_left_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("left_click"):
			return

func _on_button_pressed() -> void:
	log_checked = true
	Dialogic.start("在桌面点击日志")
	note.self_modulate = Color(1,1,1,1)
	close_button.self_modulate.a = 1
	close_button.disabled = false
	note_button.disabled = true
	game_button.disabled = true
	


func _on_关闭_pressed() -> void:
	note.self_modulate = Color(1,1,1,0)
	close_button.self_modulate.a = 0
	close_button.disabled = true
	game_button.disabled = false
	note_button.disabled = false
	
