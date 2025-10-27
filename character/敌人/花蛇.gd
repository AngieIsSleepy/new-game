extends Node2D

@onready var anim = $AnimatedSprite2D
enum State { before, born, after }
var state: State = State.before

func _ready() -> void:
	anim.play("flower")
	anim.animation_finished.connect(_on_anim_finished)
	
func _on_anim_finished() -> void:
	if state == State.born and anim.animation == "born":
		state = State.after
		anim.play("stay")


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if state == State.before and area.is_in_group("Player"):
		state = State.born
		anim.play("born")
