extends VBoxContainer

func _ready():
	var children = get_children()
	children.shuffle()
	for child in get_children():
		remove_child(child)
	for child in children:
		add_child(child)
