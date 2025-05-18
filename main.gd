extends Node2D

var camera: Camera2D

func _ready():
	# Si la cámara no está en la escena, la creamos.
	if not has_node("Camera2D"):
		camera = Camera2D.new()
		add_child(camera)
	else:
		camera = get_node("Camera2D")

	camera.make_current()  # Hacer la cámara la cámara actual

	# Verificamos que la cámara esté correctamente asignada
	if camera:
		print("Cámara asignada correctamente")
	else:
		print("No se ha encontrado el nodo Camera2D")

func _process(_delta):
	var player = get_node("Player")  # Obtener al personaje
	if player and camera:
		camera.position = player.position  # La cámara sigue al jugador
