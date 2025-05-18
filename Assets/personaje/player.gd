extends CharacterBody2D

@export var speed: float = 100.0
@export var jump_force: float = 300.0
@export var gravity: float = 800.0
var sprite: AnimatedSprite2D

@onready var camera: Camera2D = $Camera2D
@export var max_camera_distance: float = 100.0
@export var zoom_factor: float = 3

func _ready():
	sprite = $AnimatedSprite2D
	sprite.play("run")
	camera.make_current()
	camera.zoom = Vector2(10 / zoom_factor, 10 / zoom_factor)

func _physics_process(delta):
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	elif velocity.y > 0:
		velocity.y = 0

	# Saltar si está en el suelo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	# Movimiento lateral automático
	velocity.x = speed

	# Mover al personaje usando la propiedad velocity interna
	move_and_slide()

	# Animaciones
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
	else:
		if not sprite.is_playing() or sprite.animation != "run":
			sprite.play("run")

	# Cámara
	var target_position = position
	var camera_offset_x = camera.position.x - target_position.x

	if abs(camera_offset_x) > max_camera_distance:
		target_position.x = camera.position.x - sign(camera_offset_x) * max_camera_distance

	camera.position = target_position
