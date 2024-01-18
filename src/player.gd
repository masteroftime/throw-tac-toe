extends Node3D

const MOUSE_SENSITIVITY = 0.003

@onready var camera = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y = clamp(rotation.y - event.relative.x * MOUSE_SENSITIVITY, -PI/4, PI/4)
		camera.rotation.x = clamp(camera.rotation.x-event.relative.y * MOUSE_SENSITIVITY, -PI/4, PI/4)
		
		
