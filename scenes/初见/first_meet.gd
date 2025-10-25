extends Node2D

var talk_done = false

func _ready() -> void:
	$"猫大初始".modulate.a = 0.0
	_fade_in()
	
func _fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property($"猫大初始", "modulate:a", 1.0, 1)
	
func start_conversation():
	$"猫大初始".visible = true
	Dialogic.start("初见")
	
func talk() -> void:
	Dialogic.start("初见再次对话")
