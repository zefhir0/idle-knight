extends CharacterBody2D

@export var speed: float = 100.0
@export var gravity: float = 600.0
@export var jump_velocity: float = -300.0

func _physics_process(delta):
	# Movimiento automático hacia la derecha
	velocity.x = speed

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Salto (al pulsar espacio o tocar la pantalla)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
