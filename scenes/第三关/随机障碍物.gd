extends Node2D

@export var obstacle_scenes: Array[PackedScene]

@export var spawn_interval := 1.3    
@export var move_speed := 350.0   


var timer := 0.0
@export var speed_increase_rate := 5.0
var rng := RandomNumberGenerator.new()
@export var base_speed := 350.0


func _process(delta: float) -> void:
	timer += delta
	move_speed += speed_increase_rate * delta
	if timer >= spawn_interval:
		timer = 0.0
		spawn_random_obstacle()


func spawn_random_obstacle() -> void:
	if obstacle_scenes.is_empty():
		return
		
		
		
	# 随机挑选一个障碍物场景
	var index = rng.randi_range(0, obstacle_scenes.size() - 1)
	var scene = obstacle_scenes[index]

	var obstacle = scene.instantiate()
	obstacle.speed = move_speed

	obstacle.position = Vector2(1400, obstacle.default_y)

	add_child(obstacle)
	move_speed += 10.0
	
