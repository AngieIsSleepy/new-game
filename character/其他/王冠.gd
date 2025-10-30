extends Node2D
@onready var anim = $"好王冠"
@onready var anim_player := $AnimationPlayer

func _ready() -> void:
	$"坏王冠".visible = false
	
func good_crown():
	anim_player.play("new_animation")

func bad_crown():
	anim_player.play("new_animation")
	await get_tree().create_timer(1.0).timeout
	$"坏王冠".visible = true
