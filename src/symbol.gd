class_name Symbol extends RigidBody3D

enum SymbolType { NONE, X, O}

@export var type: SymbolType = SymbolType.X

var fields_entered: Array[Field] = []

func enter_field(field: Field) -> void:
	if not field in fields_entered:
		fields_entered.append(field)


func exit_field(field: Field) -> void:
	fields_entered.erase(field)


func closest_field() -> Field:
	var closest_field: Field = null
	var closest_distance := INF
	
	for field in fields_entered:
		if global_position.distance_squared_to(field.global_position) < closest_distance:
			closest_distance = global_position.distance_squared_to(field.global_position)
			closest_field = field
	
	return closest_field
