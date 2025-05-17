extends CharacterBody2D

var speed = 50  # Velocidad hacia la derecha

func _physics_process(delta):
	velocity.x = speed
	move_and_slide()
