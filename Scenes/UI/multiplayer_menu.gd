extends CanvasLayer

signal closing

@export var mp_game: PackedScene


func _ready():
	%BackButton.pressed.connect(on_quit)
	%StartButton.pressed.connect(on_start)
	
	PlayerManager.player_joined.connect(on_player_joined)
	PlayerManager.player_left.connect(on_player_left)
	
	


func _process(delta):
	PlayerManager.handle_join_input()


func on_player_joined(player: int, device: int):
	var panel = %PlayerPanelContainer.get_child(player)
	panel.player_join(device)


func on_player_left(player: int, device: int):
	var panel = %PlayerPanelContainer.get_child(player)
	panel.player_leave(device)


func on_start():
	get_tree().change_scene_to_packed(mp_game)


func on_quit():
	closing.emit()
	queue_free()
