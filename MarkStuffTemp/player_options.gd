extends PanelContainer

var selection_index: int = 0


func _ready():
	if !PlayerManager.player_data.has(owner.player_index):
		return
	
	%XSensitivitySlider.value = PlayerManager.get_player_data(owner.player_index, "sensitivity_x")
	%YSensitivitySlider.value = PlayerManager.get_player_data(owner.player_index, "sensitivity_y")
	%YInvertCheckbox.button_pressed = PlayerManager.get_player_data(owner.player_index, "y_invert")
	%XSensitivitySlider.value_changed.connect(on_x_sensitivity_changed)
	%YSensitivitySlider.value_changed.connect(on_y_sensitivity_changed)
	%YInvertCheckbox.toggled.connect(y_invert_toggled)


func _process(delta):
	if PlayerManager.get_player_count() <= 1:
		return
	
	if !PlayerManager.player_data.has(owner.player_index):
		return
		
	if owner.device_index >= 0:
		if !MultiplayerInput.device_actions.has(owner.device_index):
			return
	
	#if MultiplayerInput.is_action_just_pressed(owner.device_index, "options"):
		#visible = !visible
	
	if !visible: return
	

func on_x_sensitivity_changed(new_value):
	pass


func on_y_sensitivity_changed(new_value):
	pass


func y_invert_toggled(is_toggled):
	pass
