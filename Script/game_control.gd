extends Node3D

@export var pause_menu: PackedScene
@export var game_end_screen: PackedScene


func _ready():
	GameSignals.player_died.connect(on_player_died)


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var pause = pause_menu.instantiate()
		add_child(pause)
		get_tree().paused = true


func on_player_died():
	if PlayerManager.get_player_count() <= 1:
		var end_screen = game_end_screen.instantiate()
		add_child(end_screen)
	
	#TODO check if there is only one yeti left standing
	#that's the winner
	#add end_screen as above and set up it's label
