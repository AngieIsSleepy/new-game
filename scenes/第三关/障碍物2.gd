extends Area2D

@export var speed := 250.0
@export var default_y := 490.0
func _process(delta: float) -> void:
	position.x -= speed * delta   # 从右往左移动
	if position.x < -100:         # 离开屏幕左边就销毁
		queue_free()

func _on_body_entered(body):
	if body.name == "猫猫勇者":
		print("玩家被撞到了！")
		queue_free()
