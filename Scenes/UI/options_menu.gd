extends CanvasLayer
class_name Options

signal closing

const default_sound_level :=  0.1


func _ready():
	%BackButton.pressed.connect(on_quit)
	%BackButton.grab_focus()
	print("Loading options menu")
	
	#AUDIO SLIDERS:
	set_bus_volume(default_sound_level, "Master")
	%MasterVolumeSlider.value = get_bus_volume_percent("Master")
	%EffectsVolumeSlider.value = get_bus_volume_percent("effects")
	%MusicVolumeSlider.value = get_bus_volume_percent("music")
	%MasterVolumeSlider.value_changed.connect(on_audio_slider_changed.bind("Master"))
	%MasterVolumeSlider.drag_ended.connect(on_effects_volume_dragged)
	%EffectsVolumeSlider.value_changed.connect(on_audio_slider_changed.bind("effects"))
	%EffectsVolumeSlider.drag_ended.connect(on_effects_volume_dragged)
	%MusicVolumeSlider.value_changed.connect(on_audio_slider_changed.bind("music"))
	
	#CONTROLS:
	%MouseSensitivityXSlider.value = Settings.mouse_sensitivity_x
	%MouseSensitivityXLabel.text = "%.2f" % Settings.mouse_sensitivity_x
	%MouseSensitivityXSlider.value_changed.connect(on_mouse_x_sensitivity_changed)
	%MouseSensitivityYSlider.value = Settings.mouse_sensitivity_y
	%MouseSensitivityYLabel.text = "%.2f" % Settings.mouse_sensitivity_y
	%MouseSensitivityYSlider.value_changed.connect(on_mouse_y_sensitivity_changed)
	%InvertYCheckBox.button_pressed = Settings.invert_y_look
	%InvertYCheckBox.toggled.connect(on_invert_y_toggled)
	

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("back"):
		Callable(on_quit).call_deferred()


func get_bus_volume_percent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func set_bus_volume(volume_percent: float, bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume_percent))


func on_audio_slider_changed(new_value: float, bus_name: String):
	set_bus_volume(new_value, bus_name)
	
	#PlayerPrefs.update_setting("audio_" + bus_name, new_value)
	#settings_changed = true


func on_effects_volume_dragged(_changed: bool):
	$AudioStreamPlayer.play()


func on_mouse_x_sensitivity_changed(new_value: float):
	Settings.mouse_sensitivity_x = new_value
	%MouseSensitivityXLabel.text = "%.2f" % new_value
	#PlayerPrefs.update_setting("mouse_sensitivity_x", new_value)
	#settings_changed = true


func on_mouse_y_sensitivity_changed(new_value: float):
	Settings.mouse_sensitivity_y = new_value
	%MouseSensitivityYLabel.text = "%.2f" % new_value
	#PlayerPrefs.update_setting("mouse_sensitivity_y", new_value)
	#settings_changed = true


func on_invert_y_toggled(is_toggled: bool):
	Settings.invert_y_look = is_toggled


func on_quit():
	closing.emit()
	queue_free()
