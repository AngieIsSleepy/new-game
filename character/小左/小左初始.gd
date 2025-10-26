extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var enable_talkXZ := true
@export var enable_iconXZ := true

func _ready() -> void:
	anim.play("stand")

func show_chat_icon():
	if !enable_iconXZ:
		return
	$"感叹号".visible = true
	
func hide_chat_icon():
	if !enable_talkXZ:
		return
	$"感叹号".visible = false
