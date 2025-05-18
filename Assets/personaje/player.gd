extends CharacterBody2D

@export var speed: float = 100.0
var sprite: AnimatedSprite2D

# Asegúrate de que la cámara esté en la jerarquía del personaje en la escena
@onready var camera: Camera2D = $Camera2D

# Distancia máxima entre la cámara y el jugador en X (para evitar que la cámara se "adelante" demasiado)
@export var max_camera_distance: float = 100.0

# Factor de zoom para la cámara
@export var zoom_factor: float = 3  # Puedes ajustar este valor para acercar o alejar la cámara

func _ready():
	sprite = $AnimatedSprite2D
	sprite.play("run")  # Inicia la animación de correr
	
	# Asegura que la cámara esté activa y siga al personaje
	camera.make_current()  # Hace que esta cámara sea la cámara activa
	
	# Aplica el zoom a la cámara usando el factor exportado
	camera.zoom = Vector2(10 / zoom_factor, 10 / zoom_factor)  # Esto debería hacer el zoom correctamente

func _physics_process(_delta):
	# Movimiento automático hacia la derecha (dirección positiva en X)
	velocity.x = speed  # Puedes modificar la velocidad para ajustar el comportamiento

	# Si tu juego tiene gravedad o plataformas, puedes añadir la lógica de gravedad aquí
	if is_on_floor():
		velocity.y = 0  # Resetea la velocidad en Y si el personaje está en el suelo

	# Mueve al personaje aplicando la física
	move_and_slide()

	# Opcionalmente, actualiza la animación del sprite (asegurándose de que "run" esté en reproducción)
	if not sprite.is_playing() or sprite.animation != "run":
		sprite.play("run")

	# La cámara debe seguir al personaje en X
	var target_position = position

	# Ajustar la cámara en X, limitando su distancia máxima al jugador.
	var camera_offset_x = camera.position.x - target_position.x

	# Si la cámara está demasiado lejos en X, ajustamos su posición para que no se "adelante"
	if abs(camera_offset_x) > max_camera_distance:
		# Si la cámara está demasiado lejos en X, ajustamos su posición
		target_position.x = camera.position.x - sign(camera_offset_x) * max_camera_distance

	# Limita la posición de la cámara en el eje X para evitar que se adelante demasiado
	camera.position = target_position
