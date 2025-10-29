extends Node2D
@onready var anim = $"损坏度"
func _ready() -> void:
	anim.play("default")
	$"开发者".bad()
