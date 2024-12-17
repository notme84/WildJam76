extends RigidBody3D

@export var lifeTimer : Node

func _on_timer_timeout():
	print("removing snowball")
	queue_free()
