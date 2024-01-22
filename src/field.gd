class_name Field extends Area3D

signal symbol_changed

@onready var indicator = $Indicator

var symbol := Symbol.SymbolType.NONE:
	set(value):
		if value == Symbol.SymbolType.X:
			indicator.show()
		elif value == Symbol.SymbolType.O:
			indicator.show()
		else:
			indicator.hide()


func _ready():
	indicator.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(delta):
	if not has_overlapping_bodies():
		symbol = Symbol.SymbolType.NONE
		return
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		var areas = body

func _on_body_entered(body: Node3D) -> void:
	symbol_changed.emit()


func _on_body_exited(body: Node3D) -> void:
	symbol_changed.emit()
