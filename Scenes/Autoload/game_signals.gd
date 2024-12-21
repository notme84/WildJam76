extends Node

signal player_died


func emit_player_died():
	player_died.emit()
