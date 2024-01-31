class_name Board extends StaticBody3D

signal game_ended(result)

enum {WIN_X, WIN_O, DRAW}

@onready var fields = $Fields.get_children()

func _ready():
	for f in fields:
		f.symbol_changed.connect(_board_changed)


func _board_changed():
	for i in range(3):
		check_triple(0,i, 1,i, 2,i)
		check_triple(i,0, i,1, i,2)
	
	check_triple(0,0, 1,1, 2,2)
	check_triple(0,2, 1,1, 2,0)
		

func check_triple(a1, a2, b1, b2, c1, c2):
	if get_symbol(a1, a2) == get_symbol(b1, b2) \
		and get_symbol(a1, a2) == get_symbol(c1, c2) \
		and get_symbol(a1, a2) != Symbol.SymbolType.NONE:
			game_ended.emit(get_symbol(a1, a2))


func get_symbol(i, j) -> Symbol.SymbolType:
	assert(0 <= i and i <= 2)
	assert(0 <= j and i <= 2)
	
	return fields[j * 3 + i].symbol
