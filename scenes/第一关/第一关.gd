extends Node2D
var success = false
var pressed = false
var collected = false
@onready var bug_button = $"分层/猫猫勇者/Camera2D/bug_button"
@onready var bug_swich = $"分层/猫猫勇者/Camera2D/bug_swich"
@onready var player = $"分层/猫猫勇者"

func _ready() -> void:
	_fade_out($"里世界",0.0)
	bug_button.visible = false
	bug_swich.visible = false
	Dialogic.start("第一关")
	await Dialogic.timeline_ended
	bug_button.visible = true
	Dialogic.start("第一关2")
	player.set_process_input(false)
	player.set_physics_process(false)


func _on_timer_timeout() -> void:
	sec_60()

func _on_timer_2_timeout() -> void:
	sec_90()

func sec_60():
	if !success and !pressed:
		Dialogic.start("第一关60秒")

func sec_90():
	if !success and !pressed:
		Dialogic.start("第一关90秒")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and success == false:
		success = true
		Dialogic.start("第一关通过")

func _fade_in(node: CanvasItem, duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)

func _fade_out(node: CanvasItem, duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)

func _on_bug_button_pressed() -> void:
	bug_button.visible = false
	bug_button.disabled = true
	_fade_in($"里世界",1.0)
	Dialogic.start("初次触发里世界")
	await Dialogic.timeline_ended
	_fade_out($"里世界",1.0)
	Dialogic.start("第一关是否使用")
	await Dialogic.timeline_ended
	pressed = Dialogic.VAR.get_variable("Button1")
	_fade_out($"里世界",0.0)
	#var button1 = Dialogic.VAR.get_variable("Button1")
	$Timer.start()
	$Timer2.start()
	if pressed:
		use_bug()
	else:
		Dialogic.start("第一关不用")
		bug_swich.visible = true
	player.set_process_input(true)
	player.set_physics_process(true)


func _on_bug_swich_pressed() -> void:
	use_bug()

func use_bug():
	Global.button_count += 1
	Dialogic.VAR.set_variable("Button1",true)
	bug_swich.visible = false
	pressed = true
	player.set_collision_layer_value(2, true)
	player.set_collision_mask_value(2, true)
	player.set_collision_layer_value(1, false)
	player.set_collision_mask_value(1, false)
	Dialogic.start("图层之上")

func _on_终点_area_entered(area: Area2D) -> void:
	if !collected and area.is_in_group("Player"):
		Dialogic.start("拿补丁")
	if collected and area.is_in_group("Player"):
		if pressed:
			_go_to_next_level_with_bug()
		else:
			_go_to_next_level()

func _go_to_next_level():
	var next_scene = "res://scenes/第二关/第二关.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
	
func _go_to_next_level_with_bug():
	var next_scene = "res://scenes/通用/里世界2.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
