extends RigidBody3D

@export var lifeTimer : Node

var source: Node3D


func get_source():
	return source


func hit(hit_object):
	print("snowball hit " + hit_object.name)
	#TODO make hit impact sound, particle effect at hit point
	queue_free()


func _on_timer_timeout():
	print("removing snowball")
	queue_free()
