extends CharacterBody2D

@export var JUMP_VELOCITY = -500.0
@onready var anim = $AnimatedSprite2D
@onready var col_shape = $Area2D/shape_to_change

var original_size = Vector2.ZERO
var is_hit = false
var is_running = false

func _take_hit() -> void:
	if is_hit:
		return
	is_hit = true
	Global.third_has_died = true
	velocity = Vector2.ZERO
	anim.play("hitten")
	set_process_input(false)
	set_physics_process(false)
	await anim.animation_finished
	$"../../死亡层".get_child(0).game_over()

func _ready():
	if col_shape.shape is RectangleShape2D:
		original_size = col_shape.shape.size

func _physics_process(delta):
	if is_hit:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	if !is_running:
		velocity = Vector2.ZERO
		move_and_slide()
		anim.play("stand")
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	# jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("down") and is_on_floor():
		anim.play("duck")
		if col_shape.shape is RectangleShape2D and col_shape.shape.size == original_size:
			col_shape.shape.size = original_size * Vector2(1, 0.5) 
			col_shape.position.y += original_size.y * 0.25  
			
	else:
		anim.play("walk")
		if col_shape.shape.size != original_size:
			col_shape.shape.size = original_size
			col_shape.position.y -= original_size.y * 0.25
	move_and_slide()
	
func start_running():
	is_running = true

func stop_running():
	is_running = false
