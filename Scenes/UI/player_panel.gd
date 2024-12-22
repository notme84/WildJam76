extends PanelContainer


func player_join(device_index: int):
	%DirectionsLabel.visible = false
	%JoinedLabel.visible = true
	%DeviceIndexLabel.visible = true
	%JoinedLabel.text = "joined"
	%DeviceIndexLabel.text = "Keyboard" if device_index == -1 else "Controller"


func player_leave():
	%DirectionsLabel.visible = true
	%JoinedLabel.visible = false
	%DeviceIndexLabel.visible = false
