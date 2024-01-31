extends Node3D


func _ready():
	$Board.game_ended.connect(_game_ended)


func _game_ended(result):
	if result == Symbol.SymbolType.X:
		$WinLabel.text = "X WINS"
	elif result == Symbol.SymbolType.O:
		$WinLabel.text = "O WINS"
	else:
		$WinLabel.text = "DRAW"
	
	$WinLabel.show()
	print("Game Ended")
	print(result)
