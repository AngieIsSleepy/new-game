extends Node2D
@onready var anim := $"损坏度"
@onready var white := $"CanvasLayer/ColorRect"

func _ready() -> void:
	white.visible = true
	anim.play("default")
	$"开发者".bad()
	await _flash_in()
	
	
func _flash_in(d: float = 0.5) -> void:
	var t := create_tween()
	t.tween_property(white, "color:a", 0.0, d).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await t.finished
	white.visible = false

func _flash_out(d: float = 0.3) -> void:
	white.visible = true
	white.color = Color(1, 1, 1, 0)
	var t := create_tween()
	t.tween_property(white, "color:a", 1.0, d).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await t.finished

func talk() -> void:
	Dialogic.start("里世界2")
	await Dialogic.timeline_ended
	await _flash_out()
	_go_to_next_level()
	
func _go_to_next_level():
	var next_scene = "res://scenes/第二关/第二关.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
