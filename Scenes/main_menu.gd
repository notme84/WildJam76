extends Node

@export var game_scene: PackedScene
@export var options_scene: PackedScene
@export var credits_scene: PackedScene

#@export var mp_game_scene: PackedScene
@export var mp_menu: PackedScene


func _ready():
	%StartButton.pressed.connect(on_start)
	%OptionsButton.pressed.connect(open_submenu.bind(options_scene, %OptionsButton))
	%CreditsButton.pressed.connect(open_submenu.bind(credits_scene, %CreditsButton))
	%QuitButton.pressed.connect(on_quit)
	%MPButton.pressed.connect(open_submenu.bind(mp_menu, %MPButton))
	
	%StartButton.grab_focus()
	

func on_start():
	get_tree().change_scene_to_packed(game_scene)


func open_submenu(scene: PackedScene, button: Button):
	var submenu = scene.instantiate()
	add_child(submenu)
	submenu.closing.connect(focus_on_button.bind(button))


func focus_on_button(button: Button):
	button.grab_focus()


#func on_options_pressed():
	#var options = options_scene.instantiate()
	#add_child(options)
	#options.closing.connect(on_options_closed)
#
#
#func on_options_closed():
	#%OptionsButton.grab_focus()


func on_quit():
	get_tree().quit()
