extends Area2D

@export var speed := 250.0
@export var default_y := 550.0
func _process(delta: float) -> void:
	position.x -= speed * delta   # 从右往左移动
	if position.x < -100:         # 离开屏幕左边就销毁
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		area.get_parent()._take_hit()
