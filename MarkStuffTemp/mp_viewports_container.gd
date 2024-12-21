extends VBoxContainer

@export var player_scene: PackedScene

@export var subviewports: Array[SubViewport] = []


func _ready():
	if subviewports.size() <= 0:
		find_subviewports(self)
	
	populate_players()


func populate_players():
	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	
	var player_count = PlayerManager.get_player_count()
	if player_count <= 2:
		%SubViewportRow2.visible = false
	var temp_player_data = PlayerManager.player_data.duplicate()
	for i in subviewports.size():
		if i < player_count:
			var player_index = -1
			for j in PlayerManager.MAX_PLAYERS:
				if temp_player_data.has(j):
					player_index = j
					break
			temp_player_data.erase(player_index)
					
			var player = player_scene.instantiate()
			player.device_index = PlayerManager.get_player_data(player_index, "device")
			player.player_index = player_index#PlayerManager.get_player_data(player_index, "index")
			player.set_color(PlayerManager.player_colors[player.player_index])
			
			#TO/DO get spawn point somehow
			var spawn_pos = Vector3(randf_range(-15, 15), 0, randf_range(-15, 15))
			if spawn_points.size() > 0:
				var index = randi_range(0, spawn_points.size() - 1)
				spawn_pos = spawn_points[index].global_position
				spawn_points.remove_at(index)
			player.position = spawn_pos
				
			subviewports[i].add_child(player)
			subviewports[i].get_parent().visible = true
		else:
			subviewports[i].get_parent().visible = false
			


func _input(event: InputEvent):
	for sv in subviewports:
		sv.push_input(event)


func find_subviewports(parent):
	for child in parent.get_children():
		if child is SubViewport:
			subviewports.append(child)
		else:
			find_subviewports(child)
