extends StaticBody3D

@onready var fields = $Fields.get_children()

func _physics_process(delta):
	for field in fields:
		if not field.has_overlapping_bodies():
			field.symbol = Symbol.SymbolType.NONE
			continue
		
		
