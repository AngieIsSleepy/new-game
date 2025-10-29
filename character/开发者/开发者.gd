extends Node2D

@onready var anim = $AnimatedSprite2D

func good():
	anim.play("good_con")
	
func bad():
	anim.play("bad_con")
	
func worst():
	anim.play("worst_con")

func show_chat_icon():
	$"感叹号".visible = true
	
func hide_chat_icon():
	$"感叹号".visible = false
