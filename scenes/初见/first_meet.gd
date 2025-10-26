extends Node2D

var talk_done = false

func _ready() -> void:
	$"猫大初始".modulate.a = 0.0
	$"小左初始".modulate.a = 0.0
	$"猫大初始".enable_talkMD = false
	$"猫大初始".enable_iconMD = false
func _fade_in():
	var tween1 = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween1.tween_property($"猫大初始", "modulate:a", 1.0, 1)
	tween2.tween_property($"小左初始", "modulate:a", 1.0, 1)
	
func start_conversation():
	_fade_in()
	Dialogic.start("初见")
	
func talk() -> void:
	Dialogic.start("初见再次对话")



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and !talk_done:
		talk_done = true
		start_conversation()
