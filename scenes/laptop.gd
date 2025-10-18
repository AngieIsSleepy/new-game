extends Node2D

@onready var button = $cat_kindom_icon_button
@onready var ppt = [$ppt1, $ppt2, $ppt3]
@onready var anim = $AnimationPlayer



var current_slide := 0
var total_slides := 3
var animation_playing := false





func _ready():
	$laptop_background.set_process_input(false)
	button.pressed.connect(_on_button_pressed)
	button.self_modulate.a = 0  # 按钮透明但可点击

	for i in range(ppt.size()):
		ppt[i].visible = false
		ppt[i].z_index = 10
		
func _on_button_pressed():
	animation_playing = true
	print("开始播放幻灯片动画")
	await _play_pptshow()


# 播放ppt
func _play_pptshow():
	while current_slide < total_slides:
		# 隐藏上一个
		if current_slide > 0:
			ppt[current_slide - 1].visible = false

		ppt[current_slide].visible = true
		print("显示第 %d 张 PPT" % (current_slide + 1))
		
		current_slide += 1
		await get_tree().create_timer(1.0).timeout

	print("放完了")
	
	get_tree().change_scene_to_file("res://scenes/first_meet.tscn")
