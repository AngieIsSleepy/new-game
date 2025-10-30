extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var enable_talkMD := true
@export var enable_iconMD := true
@export var darkened = false

func _ready() -> void:
	if darkened:
		anim.play("final_stage")
	else:
		anim.play("stand")

func show_chat_icon():
	if !enable_iconMD:
		return
	$"感叹号".visible = true
	
func hide_chat_icon():
	if !enable_talkMD:
		return
	$"感叹号".visible = false

func change1():
	anim.play("first_stage")
	
func change2():
	anim.play("second_stage")
	
func change3():
	anim.play("final_stage")

func back():
	anim.play("back")

func sit():
	anim.play("stand")
