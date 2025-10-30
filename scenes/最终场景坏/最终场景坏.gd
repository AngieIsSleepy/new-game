extends Node2D
@onready var md = $"分层/猫大初始"
@onready var xz = $"分层/小左初始"
@onready var player = $"分层/猫猫勇者"
@onready var crown = $"王冠"
@onready var dev = $"分层/开发者"
@onready var broken = $"屏幕损坏"
var interact = false

func _ready() -> void:
	broken.visible = false
	md.modulate.a = 0.0
	xz.modulate.a = 0.0
	dev.modulate.a = 0.0
	crown.visible = false
	
func talk() -> void:
	var tree := get_tree()
	interact = true
	set_process_input(false)
	set_physics_process(false)
	$"祭坛".done = true
	await get_tree().create_timer(1.0).timeout
	crown.visible = true
	await crown.bad_crown()
	await get_tree().create_timer(1.0).timeout
	await md.change1()
	await xz.change1()
	await md.change2()
	await xz.change2()
	await get_tree().create_timer(1.0).timeout
	md.change3()
	xz.change3()
	await get_tree().create_timer(2.0).timeout
	Dialogic.start("坏结局")
	await Dialogic.timeline_ended
	broken.visible = true
	broken.start()
	await get_tree().create_timer(2.5).timeout
	tree.call_deferred("change_scene_to_file", "res://scenes/结局屏幕坏/结局屏幕坏.tscn")
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		_fade_in_both()
		Dialogic.start("最终结局1")
		await Dialogic.timeline_ended
		$Timer.start()

func _on_timer_timeout() -> void:
	if !interact:
		Dialogic.start("最终催促")

func _fade_in_both() -> void:
	_fade_in_side(xz, -40.0, 1)
	_fade_in_side(md, 40.0, 1)
	md.enable_talkMD = false
	md.enable_iconMD = false
	xz.enable_talkXZ = false
	xz.enable_iconXZ = false

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
