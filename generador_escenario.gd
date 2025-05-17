extends Node2D

@export var block_scenes: Array[PackedScene]
@export var player: NodePath
@export var distance_to_generate: float = 500.0
@export var block_width: int = 512

var last_x_position: float = 0.0

func _ready():
	for i in range(3):  # Genera 3 bloques al principio
		_spawn_block()

func _process(_delta):
	var jugador = get_node(player)
	if jugador.global_position.x + distance_to_generate > last_x_position:
		_spawn_block()

func _spawn_block():
	var bloque = block_scenes[randi() % block_scenes.size()].instantiate()
	bloque.position = Vector2(last_x_position, 0)
	add_child(bloque)
	last_x_position += block_width
