extends CharacterBody2D

@export var speed: float = 100.0

var sprite: AnimatedSprite2D

func _ready():
	sprite = $AnimatedSprite2D
	sprite.play("run")  # Reproducir animación de correr al inicio

func _physics_process(delta):
	velocity.x = speed  # Movimiento automático hacia la derecha
	move_and_slide()    # Mueve el personaje
