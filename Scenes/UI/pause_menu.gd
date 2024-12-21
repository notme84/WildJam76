extends CanvasLayer

@export var options_scene: PackedScene
@export var tutorial_scene: PackedScene

var submenu = null


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	%ResumeButton.pressed.connect(on_resume)
	%RestartButton.pressed.connect(on_restart)
	%TutorialButton.pressed.connect(open_submenu.bind(tutorial_scene, %TutorialButton))
	%OptionsButton.pressed.connect(open_submenu.bind(options_scene, %OptionsButton))
	%QuitButton.pressed.connect(on_quit)
	
	%ResumeButton.grab_focus()


func _input(event: InputEvent):
	if submenu != null:
		return
	
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("back"):
		Callable(on_resume).call_deferred()


func on_resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()


func on_restart():
	get_tree().paused = false
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)


func open_submenu(menu_scene: PackedScene, button: Button):
	submenu = menu_scene.instantiate()
	submenu.closing.connect(close_submenu)
	submenu.closing.connect(focus_on_button.bind(button))
	get_parent().add_child(submenu)


func close_submenu():
	if submenu == null: return
	submenu = null


func focus_on_button(button: Button):
	button.grab_focus()


#func on_options_pressed():
	#var options = options_scene.instantiate()
	#options.closing.connect(on_options_closed)
	#get_parent().add_child(options)
#
#
#func on_options_closed():
	#%OptionsButton.grab_focus()


func on_quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
