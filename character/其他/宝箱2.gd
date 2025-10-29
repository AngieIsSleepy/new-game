extends Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var opened = false

func _ready() -> void:
	anim.play("closed")
	
func open():
	if opened == false:
		opened = true
		anim.play("open")
		Dialogic.start("宝箱2打开")
		await Dialogic.timeline_ended
		if get_parent().get_parent().pressed:
			Dialogic.start("第二关使用")
		else:
			Dialogic.start("第二关不使用")
		await Dialogic.timeline_ended
