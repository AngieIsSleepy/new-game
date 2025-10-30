extends Node2D
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.visible = false
	Dialogic.start("删除")
	await Dialogic.timeline_ended
	anim.visible = true
	anim.play("start")
	Dialogic.start("问号")
	await Dialogic.timeline_ended
	anim.play("brake")
	Dialogic.start("走不了了")
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://scenes/结局/坏结局.tscn")
