extends Node2D
@onready var platform = $"平台"
@onready var player = $"分层/猫猫勇者第三关"
@onready var obstacle = $"随机障碍物"
@onready var new_player = $"分层/猫猫勇者第三关2"
@onready var timer_label = $"计时器"
@onready var bug_swich = $bug_swich

var pressed = false
var collected = false
var remaining_time = 30.0
var counting = false

func _ready() -> void:
	$"宝箱3".visible = false
	new_player.visible = false
	if !Global.third_has_died:
		Dialogic.start("第三关入场")
		await Dialogic.timeline_ended
	platform.start_scroll()
	obstacle.start_spawn()
	player.start_running()
	$Timer.start()
	remaining_time = 30.0
	_update_timer_label()
	counting = true
	$Timer.wait_time = 30.0
	$Timer.start()
	if Global.button_count == 2:
		use_bug()

func _process(delta: float) -> void:
	if counting:
		remaining_time -= delta
		if remaining_time < 0.0:
			remaining_time = 0.0
		_update_timer_label()

func _update_timer_label() -> void:
	var seconds := int(ceil(remaining_time))
	var text := "00:" + str(seconds).pad_zeros(2)
	timer_label.text = text

func _swap_to_alt_player() -> void:
	player.set_collision_layer_value(1,false)
	player.set_collision_mask_value(1,false)
	var old_pos = player.global_position
	new_player.global_position = old_pos
	player.visible = false
	new_player.visible = true
	player = new_player

func _on_timer_timeout() -> void:
	$"宝箱3".visible = true
	timer_label.visible = false
	bug_swich.visible = false
	counting = false
	platform.stop_scroll()
	obstacle.stop_spawn()
	player.stop_running()
	for child in obstacle.get_children():
		child.queue_free()
	_swap_to_alt_player()

func _on_bug_swich_pressed() -> void:
	use_bug()

func use_bug():
	Global.button_count += 1
	Dialogic.start("第三关按钮")
	bug_swich.visible = false
	pressed = true
	$Timer.timeout.emit()
	if Global.button_count == 2:
		Dialogic.start("第三关按下")
		await Dialogic.timeline_ended
	
func _on_终点_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and !collected:
		Dialogic.start("拿补丁")
	if collected and area.is_in_group("Player"):
		if pressed:
			call_deferred("_go_to_next_level_with_bug")
		else:
			call_deferred("_go_to_next_level")

func _go_to_next_level():
	var next_scene1 = "res://scenes/最终场景坏/最终场景坏.tscn"
	var next_scene2 = "res://scenes/最终场景/最终场景.tscn"
	if Global.button_count >= 2:
		GameLoad.current_scene_path = next_scene1
		GameLoad.save_game()
		get_tree().change_scene_to_file(next_scene1)
	else:
		GameLoad.current_scene_path = next_scene2
		GameLoad.save_game()
		get_tree().change_scene_to_file(next_scene2)
		
func _go_to_next_level_with_bug():
	var next_scene = "res://scenes/通用/里世界4.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
