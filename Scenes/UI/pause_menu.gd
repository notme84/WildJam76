extends CanvasLayer

@export var options_scene: PackedScene


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	%ResumeButton.pressed.connect(on_resume)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit)
	
	%ResumeButton.grab_focus()


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("back"):
		Callable(on_resume).call_deferred()


func on_resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()


func on_options_pressed():
	var options = options_scene.instantiate()
	options.closing.connect(on_options_closed)
	get_parent().add_child(options)


func on_options_closed():
	%OptionsButton.grab_focus()


func on_quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
