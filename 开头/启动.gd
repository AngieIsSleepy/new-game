extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_playAnim("Logo1")

func _playAnim(str:String):
	animation_player.play(str)

func _on_animation_finished()->void:
	get_tree().change_scene_to_file("res://开头/开头重制版.tscn")
