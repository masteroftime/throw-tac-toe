extends Node3D

const MOUSE_SENSITIVITY = 0.003
const THROW_SPEED = 2

const SymbolX = preload("res://src/symbol_x.tscn")
const SymbolO = preload("res://src/symbol_o.tscn")

enum { SYMBOL_X, SYMBOL_O }

var current_symbol = SYMBOL_X

@onready var camera = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y = clamp(rotation.y - event.relative.x * MOUSE_SENSITIVITY, -PI/4, PI/4)
		camera.rotation.x = clamp(camera.rotation.x-event.relative.y * MOUSE_SENSITIVITY, -PI/4, PI/4)
		
	if event.is_action_pressed("throw"):
		var symbol = get_current_symbol_instance()
		symbol.position = global_position
		symbol.linear_velocity = -camera.global_basis.z * THROW_SPEED
		get_tree().root.add_child(symbol)


func get_current_symbol_instance() -> Node:
	if current_symbol == SYMBOL_X:
		current_symbol = SYMBOL_O
		return SymbolX.instantiate()
	else:
		current_symbol = SYMBOL_X
		return SymbolO.instantiate()
