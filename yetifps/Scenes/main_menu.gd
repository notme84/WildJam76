extends Node

@export var game_scene: PackedScene
@export var options_scene: PackedScene


func _ready():
	%StartButton.pressed.connect(on_start)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit)
	
	%StartButton.grab_focus()
	

func on_start():
	get_tree().change_scene_to_packed(game_scene)


func on_options_pressed():
	var options = options_scene.instantiate()
	add_child(options)
	options.closing.connect(on_options_closed)


func on_options_closed():
	%OptionsButton.grab_focus()


func on_quit():
	get_tree().quit()
