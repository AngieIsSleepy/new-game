extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("stand")

func show_chat_icon():
	$"感叹号".visible = true
	
func hide_chat_icon():
	$"感叹号".visible = false
