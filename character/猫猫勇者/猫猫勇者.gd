extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@export var speed = 200.0
#test
func _physics_process(delta):
	var dir = Vector2.ZERO

	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("up"):
		dir.y -= 1


	if dir != Vector2.ZERO:
		dir = dir.normalized()
		velocity = dir * speed
		move_and_slide()
		
		#播放动画
		anim.play("walk")

		#翻转
		if dir.x < 0:
			anim.flip_h = true   
		elif dir.x > 0:
			anim.flip_h = false  

	else:
		velocity = Vector2.ZERO
		move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("NPC"):
		area.get_parent().show_chat_icon()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("NPC"):
		area.get_parent().hide_chat_icon()
