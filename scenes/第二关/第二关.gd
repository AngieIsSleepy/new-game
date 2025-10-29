extends Node2D
var collected = false
@onready var bug_swich = $"猫猫勇者第二关/Camera2D/bug_swich"
@onready var player = $"猫猫勇者第二关"
@onready var dirt = $TileMapLayer3
@onready var square = $TileMapLayer
@onready var error_layer = $"材质丢失"

var pressed = false
func _ready() -> void:
	$"猫猫勇者第二关/Camera2D/里世界3".visible = false
	error_layer.visible = false
	if Global.second_has_died:
		print("玩家死过，跳过开场对话")
	else:
		Dialogic.start("第二关入场")

func _on_bug_swich_pressed() -> void:
	use_bug()

func use_bug():
	Dialogic.start("第二关按钮")
	bug_swich.visible = false
	pressed = true
	dirt.enabled = false
	square.enabled = false
	error_layer.visible = true

func _on_终点_area_entered(area: Area2D) -> void:
	if !collected:
		Dialogic.start("拿补丁")
	if collected and area.is_in_group("Player"):
		if pressed:
			$"宝箱2".visible = false
			$"猫猫勇者第二关/Camera2D/里世界3".visible = true
			Dialogic.start("里世界3")
			await Dialogic.timeline_ended
			$"猫猫勇者第二关/Camera2D/里世界3".visible = false
			
		_go_to_next_level()

func _go_to_next_level():
	var next_scene = "res://scenes/第三关/第三关.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
