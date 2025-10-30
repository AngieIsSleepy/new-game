extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@export var speed := 200.0
@export var JUMP_VELOCITY := -500.0   # W 跳的力度

var talk := false
var in_talk := false
var last_dir := Vector2.RIGHT
var is_hit := false

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialog_started)
	Dialogic.timeline_ended.connect(_on_dialog_ended)

func _on_dialog_started():
	in_talk = true
	_play_stand()

func _on_dialog_ended():
	in_talk = false

func _physics_process(delta: float) -> void:
	# 受击就啥也不做
	if is_hit:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# 对话中也不让动
	if in_talk:
		velocity = Vector2.ZERO
		move_and_slide()
		_play_stand()
		return

	# 先加重力（你项目里如果有 project gravity，这句就能用）
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ---- 左右移动（A / D）----
	var dir_x := 0.0
	if Input.is_action_pressed("left"):   # A
		dir_x -= 1.0
	if Input.is_action_pressed("right"):  # D
		dir_x += 1.0
	velocity.x = dir_x * speed

	# ---- 跳跃（W）----
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# ---- 蹲下（S）----
	# 只在地上蹲，空中不蹲
	if Input.is_action_pressed("down") and is_on_floor():
		# 按住 S：保持下蹲
		if anim.animation != "duck":
			anim.play("duck")
	else:
		# 没有按 S，就根据是否在走路来切换动画
		if dir_x != 0:
			# 朝向
			if dir_x < 0:
				anim.flip_h = true
				last_dir = Vector2.LEFT
			else:
				anim.flip_h = false
				last_dir = Vector2.RIGHT
			if anim.animation != "walk":
				anim.play("walk")
		else:
			_play_stand()

	# 真正移动
	move_and_slide()

	# 对话键
	if talk and Input.is_action_just_pressed("interact"):
		get_parent().talk()

func _play_stand() -> void:
	# 站立时保持上一次的朝向
	if last_dir.x != 0:
		anim.flip_h = (last_dir.x < 0)
	if anim.animation != "stand" or not anim.is_playing():
		anim.play("stand")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("NPC"):
		area.get_parent().show_chat_icon()
		talk = true
	if area.is_in_group("Enemy"):
		_take_hit()
	if area.is_in_group("Chest"):
		get_parent().get_parent().collected = true
		area.get_parent().open()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("NPC"):
		area.get_parent().hide_chat_icon()
		talk = false

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
	$"../../死亡层".get_child(0).game_over()
