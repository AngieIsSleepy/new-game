extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var anim = $AnimatedSprite2D
@onready var label = $Label

var can_click := false

func _ready():
	anim.modulate.a = 0.0
	label.visible = false 
	anim.play("default")  
	_fade_in(anim, 1.0)
		 
	await get_tree().create_timer(5).timeout 
	label.visible = true
	can_click = true 
	print("动画结束，可以点击返回主菜单")
	set_process_input(true)  

func _unhandled_input(event):
	if can_click and event is InputEventMouseButton and event.pressed:
		can_click = false
		await _fade_out(anim, 1.0)
		get_tree().change_scene_to_file("res://scenes/开头/开始菜单.tscn")

	
func _fade_in(node: CanvasItem, duration: float) -> void:
	var tw := get_tree().create_tween()
	tw.set_trans(Tween.TRANS_SINE)
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_property(node, "modulate:a", 1.0, duration)
	await tw.finished


func _fade_out(node: CanvasItem, duration: float) -> void:
	var tw := get_tree().create_tween()
	tw.set_trans(Tween.TRANS_SINE)
	tw.set_ease(Tween.EASE_IN)
	tw.tween_property(node, "modulate:a", 0.0, duration)
	await tw.finished
