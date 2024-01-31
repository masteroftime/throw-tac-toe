class_name Field extends Area3D

signal symbol_changed

@onready var indicator = $Indicator
@onready var material = indicator.get_surface_override_material(0)

var symbol := Symbol.SymbolType.NONE:
	set(value):
		if value == symbol:
			return
		
		symbol = value
		
		if value == Symbol.SymbolType.X:
			indicator.show()
			material.albedo_color = Color.RED
		elif value == Symbol.SymbolType.O:
			indicator.show()
			material.albedo_color = Color.BLUE
		else:
			indicator.hide()
		
		symbol_changed.emit()

func _ready():
	indicator.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(delta):	
	var closest_symbol = null
	var closest_distance = INF
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.closest_field() != self:
			continue
		
		if body.global_position.distance_squared_to(global_position) < closest_distance:
			closest_symbol = body
			closest_distance = body.global_position.distance_squared_to(global_position)
	
	if closest_symbol == null:
		symbol = Symbol.SymbolType.NONE
	else:
		symbol = closest_symbol.type

func _on_body_entered(body: Node3D) -> void:
	if body is Symbol:
		body.enter_field(self)


func _on_body_exited(body: Node3D) -> void:
	if body is Symbol:
		body.exit_field(self)
