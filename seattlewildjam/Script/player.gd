extends CharacterBody2D
@export var speed = 5

func get_input(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * (speed / delta)
	
func _physics_process(delta):
	get_input(delta)
	move_and_slide()
