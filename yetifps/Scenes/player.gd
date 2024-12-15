extends CharacterBody3D
@export var speed:int = 10

func _physics_process(delta):
	var input_vector: Vector3 = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
		
	velocity = input_vector * speed
	move_and_slide()
