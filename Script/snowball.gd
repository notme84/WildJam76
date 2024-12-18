extends RigidBody3D

@export var lifeTimer : Node

var source: Node3D


func get_source():
	return source


func _on_timer_timeout():
	print("removing snowball")
	queue_free()
