extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var grid_size: float = 64.0
var moving := false
var state: int = 0
var is_hit := false
var in_talk = false

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialog_started)
	Dialogic.timeline_ended.connect(_on_dialog_ended)

func _on_dialog_started():
	in_talk = true
	print("对话开始，禁止移动")

func _on_dialog_ended():
	in_talk = false
	print("对话结束，恢复移动")

func _physics_process(_delta: float) -> void:
	if moving or in_talk or is_hit:
		return

	var dir := Vector2.ZERO
	if Input.is_action_just_pressed("up"):
		dir = Vector2.UP
	elif Input.is_action_just_pressed("down"):
		dir = Vector2.DOWN
	elif Input.is_action_just_pressed("left"):
		dir = Vector2.LEFT
	elif Input.is_action_just_pressed("right"):
		dir = Vector2.RIGHT

	if dir != Vector2.ZERO:
		_move_one_step(dir)

func _move_one_step(dir: Vector2) -> void:
	if moving or in_talk or is_hit:
		return
	var motion := dir * grid_size
	if test_move(global_transform, motion):
		return
	moving = true

	global_position += dir * grid_size

	if anim.animation != "change":
		anim.animation = "change"

	var frame_count := anim.sprite_frames.get_frame_count("change")
	if frame_count > 0:
		state = (state + 1) % frame_count   # 颜色循环
		anim.animation = "change"
		anim.frame = state
		print(state)
	_after_step_check()
	moving = false

func _take_hit() -> void:
	if is_hit:
		return
	is_hit = true
	velocity = Vector2.ZERO
	anim.play("hitten")
	await anim.animation_finished
	set_process_input(false)
	set_physics_process(false)
	await get_tree().create_timer(1.0).timeout
	$"../死亡层".get_child(0).game_over()

func _after_step_check():
	var cid = _get_active_tile_color_at(global_position)
	if cid == null:
		return                # 该层禁用或脚下无tile → 安全
	if state != cid:
		_take_hit()          # 颜色不同 → 死亡

func _get_active_tile_color_at(world_pos: Vector2) -> Variant:
	var l: TileMapLayer = $"../TileMapLayer"  # ← 按你的节点路径改
	if not l.enabled:
		return null                           # 层被禁用时不参与判定

	# 把世界坐标转换到该层的格坐标
	var cell: Vector2i = l.local_to_map(l.to_local(world_pos))
	var td := l.get_cell_tile_data(cell)
	if td == null:
		return null

	var cid = td.get_custom_data("color_id")
	return cid if typeof(cid) == TYPE_INT else null


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Chest"):
		get_parent().collected = true
		area.get_parent().open()
