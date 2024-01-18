extends Node3D

const MOUSE_SENSITIVITY = 0.003
const THROW_SPEED = 2

const SymbolX = preload("res://src/symbol_x.tscn")

@onready var camera = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y = clamp(rotation.y - event.relative.x * MOUSE_SENSITIVITY, -PI/4, PI/4)
		camera.rotation.x = clamp(camera.rotation.x-event.relative.y * MOUSE_SENSITIVITY, -PI/4, PI/4)
		
	if event.is_action_pressed("throw"):
		var symbol = SymbolX.instantiate()
		symbol.position = global_position
		symbol.linear_velocity = -basis.z * THROW_SPEED
		get_parent_node_3d().add_child(symbol)
