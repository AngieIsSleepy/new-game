extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@export var speed = 200.0

var talk = false
var in_talk = false
var last_dir := Vector2.RIGHT
var is_hit := false

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialog_started)
	Dialogic.timeline_ended.connect(_on_dialog_ended)
	
func _on_dialog_started():
	in_talk = true
	print("对话开始，禁止移动")
	_play_stand()

func _on_dialog_ended():
	in_talk = false
	print("对话结束，恢复移动")
#test
func _physics_process(_delta):
	if in_talk or is_hit:
		velocity = Vector2.ZERO
		move_and_slide()
		if !is_hit:
			_play_stand()
		return
	var dir = Vector2.ZERO

	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("up"):
		dir.y -= 1

	if talk and Input.is_action_just_pressed("interact"):
		get_parent().talk()
		
	if dir != Vector2.ZERO:
		dir = dir.normalized()
		velocity = dir * speed
		move_and_slide()
		if dir.x != 0: 
			last_dir.x = dir.x
		if dir.y != 0: 
			last_dir.y = dir.y
		
		if anim.animation != "walk" or anim.is_playing() == false:
			anim.play("walk")
			

		#翻转
		if dir.x < 0:
			anim.flip_h = true   
		elif dir.x > 0:
			anim.flip_h = false  

	else:
		velocity = Vector2.ZERO
		move_and_slide()
		_play_stand()
				
				
func _play_stand() -> void:
	# 根据上次水平方向设置朝向
	if last_dir.x != 0:
		anim.flip_h = (last_dir.x < 0)
	# 播放 stand（避免每帧重置）
	if anim.animation != "stand" or not anim.is_playing():
		# 如果你的 stand 是单帧，就把 speed_scale 设 0；如果是循环待机，设 1
		anim.speed_scale = 1.0   # 单帧待机；如果是循环待机，改成 1.0
		anim.play("stand")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("NPC"):
		area.get_parent().show_chat_icon()
		talk = true
	if area.is_in_group("Enemy"):
		_take_hit()


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
	$"../死亡层".get_child(0).game_over()


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
