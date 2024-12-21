extends CanvasLayer


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	%RestartButton.pressed.connect(on_restart)
	%QuitButton.pressed.connect(on_quit)
	
	%RestartButton.grab_focus()


func setup_label(text: String):
	%WinLabel.text = text


func on_restart():
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)


func on_quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
