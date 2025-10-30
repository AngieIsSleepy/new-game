extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var button = $AnimatedSprite2D2

func _ready() -> void:
	button.visible = false
	anim.visible = false
	
func start():
	anim.visible = true
	anim.play("default")
	await get_tree().create_timer(2.0).timeout
	button.visible = true
