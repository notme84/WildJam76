extends Node3D

@export var pause_menu: PackedScene
@export var game_end_screen: PackedScene


func _ready():
	GameSignals.player_died.connect(on_player_died)


func _input(event: InputEvent):
	if event.is_action_pressed("options"):
		var pause = pause_menu.instantiate()
		add_child(pause)
		get_tree().paused = true


func on_player_died():
	if PlayerManager.get_player_count() <= 1:
		var end_screen = game_end_screen.instantiate()
		end_screen.setup_label("ALAS, POOR YETI")
		add_child(end_screen)
	
	#TODO check if there is only one yeti left standing
	#that's the winner
	#add end_screen as above and set up it's label
	var players = get_tree().get_nodes_in_group("player")
	var alive_count: int = 0
	var winner: int = -1
	for i in players.size():
		if players[i].alive:
			alive_count += 1
			winner = players[i].player_index
	if alive_count > 1:
		return
	
	var end_screen = game_end_screen.instantiate()
	add_child(end_screen)
	if alive_count <= 0:
		end_screen.setup_label("NO YETI WON!")
	else: end_screen.setup_label("YETI " + str(winner + 1) + " HAS WON!")
	
	
