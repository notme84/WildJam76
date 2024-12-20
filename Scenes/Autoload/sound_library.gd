extends Node

@export var throw_sounds: Array[AudioStream] = []
@export var footsteps: Array[AudioStream] = []


func get_throw_sound() -> AudioStream:
	return throw_sounds.pick_random()


func get_footstep() -> AudioStream:
	return footsteps.pick_random()
