extends Node3D

signal symbol_thrown(symbol: Symbol.SymbolType)

const MOUSE_SENSITIVITY := 0.003
const THROW_SPEED := 3.0

const SymbolX = preload("res://src/symbol_x.tscn")
const SymbolO = preload("res://src/symbol_o.tscn")



var current_symbol = Symbol.SymbolType.O
var charge := 0.0

@onready var camera = $Camera3D
@onready var throw_point = %ThrowPoint
@onready var charge_bar = %ChargeBar


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y = clamp(rotation.y - event.relative.x * MOUSE_SENSITIVITY, -PI/4, PI/4)
		camera.rotation.x = clamp(camera.rotation.x-event.relative.y * MOUSE_SENSITIVITY, -PI/4, PI/4)
		
	if event.is_action_pressed("throw"):
		charge = 0.0
		charge_bar.value = 0.0
		charge_bar.show()
	
	if event.is_action_released("throw"):
		symbol_thrown.emit(current_symbol)
		var symbol = get_current_symbol_instance()
		symbol.position = throw_point.global_position
		symbol.linear_velocity = -throw_point.global_basis.z * THROW_SPEED * charge
		get_tree().root.add_child(symbol)
		charge_bar.hide()


func _process(delta):
	if Input.is_action_pressed("throw"):
		charge = clamp(charge + delta, 0, 1)
		charge_bar.value = charge


func get_current_symbol_instance() -> Node:
	if current_symbol == Symbol.SymbolType.X:
		current_symbol = Symbol.SymbolType.O
		return SymbolX.instantiate()
	else:
		current_symbol = Symbol.SymbolType.X
		return SymbolO.instantiate()
