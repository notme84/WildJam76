extends VBoxContainer

@export var player_scene: PackedScene

@export var subviewports: Array[SubViewport] = []


func _ready():
	if subviewports.size() <= 0:
		find_subviewports(self)
	
	populate_players()


func populate_players():
	var player_count = PlayerManager.get_player_count()
	if player_count <= 2:
		%SubViewportRow2.visible = false
	for i in subviewports.size():
		if i < player_count:
			var player = player_scene.instantiate()
			#TODO get spawn point somehow
			player.position = Vector3(randf_range(-15, 15), 0, randf_range(-15, 15))
			player.device_index = PlayerManager.get_player_data(i, "device")
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
