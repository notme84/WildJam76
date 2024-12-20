extends Node3D

@export var pause_menu: PackedScene

func _ready():
	pass


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var pause = pause_menu.instantiate()
		add_child(pause)
		get_tree().paused = true
