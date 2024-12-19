extends PanelContainer


func player_join(device_index: int):
	%JoinedLabel.text = "joined"
	%DeviceIndexLabel.text = str(device_index)


func player_leave():
	%JoinedLabel.text = ""
	%DeviceIndexLabel.text = ""
