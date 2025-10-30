extends Node2D

var talk_done = false

func _ready() -> void:
	$"分层/猫大初始".modulate.a = 0.0
	$"分层/小左初始".modulate.a = 0.0
	$"分层/猫大初始".enable_talkMD = false
	$"分层/猫大初始".enable_iconMD = false

func _fade_in_both() -> void:
	# 并行启动两个淡入
	_fade_in_side($"分层/小左初始", -40.0, 0.9)
	_fade_in_side($"分层/猫大初始", 40.0, 0.9)
	# 淡入完成后再允许交互/图标
	$"分层/猫大初始".enable_talkMD = false
	$"分层/猫大初始".enable_iconMD = false
	$"分层/小左初始".enable_talkXZ = true
	$"分层/小左初始".enable_iconXZ = true

func _fade_in_side(node: Node2D, dist, duration) -> void:
	var target = node.position
	var offset_x = (dist) 
	var start = target + Vector2(offset_x, 0)
	node.position = start
	node.modulate.a = 0.0
	var tw := get_tree().create_tween()
	tw.set_parallel(true)
	tw.set_trans(Tween.TRANS_SINE)
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_property(node, "position", target, duration)
	tw.tween_property(node, "modulate:a", 1.0, duration)
	await tw.finished

func start_conversation():
	_fade_in_both()
	Dialogic.start("初见")

func talk() -> void:
	Dialogic.start("初见再次对话")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and !talk_done:
		talk_done = true
		start_conversation()

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		_go_to_next_level()
		
func _go_to_next_level():
	var next_scene = "res://scenes/第一关/第一关.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().call_deferred("change_scene_to_file", next_scene)
