extends VBoxContainer

var subviewports: Array[SubViewport] = []


func _ready():
	find_subviewports(self)


func _input(event: InputEvent):
	for sv in subviewports:
		sv.push_input(event)


func find_subviewports(parent):
	for child in parent.get_children():
		if child is SubViewport:
			subviewports.append(child)
		else:
			find_subviewports(child)
