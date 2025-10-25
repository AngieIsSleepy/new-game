extends Control

@onready var ppt = [$ppt1, $ppt2, $ppt3]
@onready var black_screen: ColorRect = $Black
@onready var label = $Label

@onready var game_button = $"VBoxContainer/开始游戏"
@onready var continue_button = $"VBoxContainer/继续游戏"
@onready var quit_button = $"VBoxContainer/退出游戏"

var current_slide := 0
var total_slides := 3
var animation_playing := false

func _fade_to_black(duration := 1.0) -> void:
	black_screen.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(black_screen, "color:a", 1.0, duration)
	await tween.finished
	
func _wait_for_left_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("left_click"):
			return

func _play_pptshow():
	while current_slide < total_slides:
		# 隐藏上一个
		if current_slide > 0:
			ppt[current_slide - 1].visible = false
		ppt[current_slide].visible = true
		print("显示第 %d 张 PPT" % (current_slide + 1))
		
		current_slide += 1
		await get_tree().create_timer(2.0).timeout
	label.visible = true
	print("放完了")
	await _wait_for_left_click()
	black_screen.visible = true
	label.visible = false
	ppt[2].visible = false
	Dialogic.start("name")
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://scenes/初见/first_meet.tscn")

func _on_开始游戏_pressed() -> void:
	game_button.disabled = true
	continue_button.disabled = true
	quit_button.disabled = true
	await _fade_to_black()
	black_screen.visible = false
	animation_playing = true
	print("开始播放幻灯片动画")
	await _play_pptshow()


func _on_继续游戏_pressed() -> void:
	pass # Replace with function body.


func _on_退出游戏_pressed() -> void:
	Dialogic.start("主菜单")

func _ready():
	black_screen.color = Color(0,0,0,0)
	black_screen.visible = false
	label.visible = false
	for i in range(ppt.size()):
		ppt[i].visible = false
