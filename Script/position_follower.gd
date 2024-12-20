extends Node3D

@export var target: Node3D


func _process(delta):
	if target == null:
		printerr("NO TARGET ASSIGNED TO POSITION FOLLOWER")
		return
	
	global_position = target.global_position
