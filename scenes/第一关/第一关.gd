extends Node2D
var success = false

func _ready() -> void:
	Dialogic.start("第一关")
	
func _physics_process(_delta: float) -> void:
	if $"分层/猫猫勇者".position.x >= 1800:
		success = true
	if success:
		Dialogic.start("第一关通过")

func _on_timer_timeout() -> void:
	sec_60()

func _on_timer_2_timeout() -> void:
	sec_90()

func sec_60():
	if !success:
		Dialogic.start("第一关60秒")

func sec_90():
	if !success:
		Dialogic.start("第一关90秒")
