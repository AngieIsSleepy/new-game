extends Node2D
var collected = false
@onready var bug_swich = $"分层/猫猫勇者第二关/Camera2D/bug_swich"
@onready var player = $"分层/猫猫勇者第二关"
@onready var dirt = $TileMapLayer3
@onready var square = $TileMapLayer
@onready var error_layer = $"材质丢失"
@onready var cam = $"分层/猫猫勇者第二关/Camera2D"

var pressed = false
func _ready() -> void:
	$"分层/猫猫勇者".visible = false
	error_layer.visible = false
	if !Global.second_has_died:
		Dialogic.start("第二关入场")

func _on_bug_swich_pressed() -> void:
	use_bug()

func use_bug():
	Global.button_count += 1
	Dialogic.start("第二关按钮")
	bug_swich.visible = false
	pressed = true
	dirt.enabled = false
	square.enabled = false
	error_layer.visible = true
	_swap_to_alt_player()

func _swap_to_alt_player() -> void:
	player.set_collision_layer_value(1,false)
	player.set_collision_mask_value(1,false)
	var old_pos = player.global_position
	$"分层/猫猫勇者".global_position = old_pos
	player.visible = false
	$"分层/猫猫勇者".visible = true
	var cam_local = cam.position
	player.remove_child(cam)
	$"分层/猫猫勇者".add_child(cam)
	cam.position = cam_local
	cam.make_current()
	player = $"分层/猫猫勇者"
	
	
func _on_终点_area_entered(area: Area2D) -> void:
	if !collected and area.is_in_group("Player"):
		Dialogic.start("拿补丁")
	if collected and area.is_in_group("Player"):
		if pressed:
			_go_to_next_level_with_bug()
		else:
			_go_to_next_level()
		
func _go_to_next_level():
	var next_scene = "res://scenes/第三关/第三关.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
	
func _go_to_next_level_with_bug():
	var next_scene = "res://scenes/通用/里世界3.tscn"
	GameLoad.current_scene_path = next_scene
	GameLoad.save_game()
	get_tree().change_scene_to_file(next_scene)
