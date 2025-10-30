extends Node2D
@export var speed := 250.0
@onready var tiles := [$平台1, $平台2, $平台3]

const WIDTH := 1270.0
var running = false

func _ready():
	for i in range(tiles.size()):
		tiles[i].position.x = i * WIDTH

func _physics_process(delta):
	if not running:
		return

	for tile in tiles:
		tile.position.x -= speed * delta

	for tile in tiles:
		if tile.position.x <= -WIDTH:
			var rightmost_x := -INF
			for t in tiles:
				rightmost_x = max(rightmost_x, t.position.x)
			tile.position.x = rightmost_x + WIDTH
			
func start_scroll():
	running = true

func stop_scroll():
	running = false
