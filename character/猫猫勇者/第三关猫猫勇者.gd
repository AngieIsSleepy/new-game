extends CharacterBody2D

@export var JUMP_VELOCITY = -500.0
@onready var anim = $AnimatedSprite2D
@onready var col_shape: CollisionShape2D = $shape_to_change
var is_hit := false
var original_size := Vector2.ZERO

func _ready():
	if col_shape.shape is RectangleShape2D:
		original_size = col_shape.shape.size
		
		
func _take_hit() -> void:
	if is_hit:
		return
	Global.third_has_died = true
	is_hit = true
	velocity = Vector2.ZERO
	anim.play("hitten")
	await anim.animation_finished
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	$"../../死亡层".get_child(0).game_over()
	
	
func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 动画切换逻辑
	if Input.is_action_pressed("down") and is_on_floor():
		# 按住S：保持下蹲
		anim.play("duck")
		if col_shape.shape is RectangleShape2D and col_shape.shape.size == original_size:
			col_shape.shape.size = original_size * Vector2(1, 0.5) 
			col_shape.position.y += original_size.y * 0.25  
		
	else:
		anim.play("walk")
		if col_shape.shape.size != original_size:
			col_shape.shape.size = original_size
			col_shape.position.y -= original_size.y * 0.25  # 复原位置
	

	move_and_slide()
