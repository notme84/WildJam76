extends CharacterBody3D

signal attack_1_pressed
signal attack_2_pressed
signal melee_pressed

@onready var camera: Camera3D = %Camera3D

@export var pause_menu: PackedScene

@export var character_animator: AnimationPlayer

@export var speed: float = 10
@export var acceleration: float = 5

@export var snowballScene : PackedScene
@onready var snowballSpawn = $RotationRoot/meatMachine_yeti6/snowballSpawn

var camrot_h: float
var camrot_v: float
@export var cam_v_min: float = -80
@export var cam_v_max: float = 80
var h_acceleration: float = 10
var v_acceleration: float = 10

var speed_mult: float = 1.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var using_follow_cam: bool = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var pause = pause_menu.instantiate()
		get_parent().add_child(pause)
		get_tree().paused = true
		#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			camrot_h -= event.relative.x * Settings.mouse_sensitivity_x
			if Settings.invert_y_look:
				camrot_v += event.relative.y * Settings.mouse_sensitivity_y
			else: camrot_v -= event.relative.y * Settings.mouse_sensitivity_y
	
	if event.is_action_pressed("camera_mode"):
		#SWITCH BETWEEN FIRST AND THIRD PERSON
		if camera.get_parent() == %HeadCameraMount:
			camera.reparent(%FollowCameraHousing)
			using_follow_cam = true
		else: 
			camera.reparent(%HeadCameraMount)
			using_follow_cam = false
		camera.position = Vector3.ZERO
		camera.rotation = Vector3.ZERO
		
	if event.is_action_pressed("throw"):
		var snowball = snowballScene.instantiate()
		var throwSpeed = 30
		add_sibling(snowball)
		snowball.transform = snowballSpawn.global_transform
		#var throwDirection = Vector3(0, 0, velocity.z * -1 * throwSpeed)
		#snowball.linear_velocity = throwDirection
		snowball.linear_velocity = snowballSpawn.global_transform.basis.z * -1 * throwSpeed
		print("throw!")
		attack_1_pressed.emit()
	
	if event.is_action_pressed("right_click"):
		print("BREATH!!")
		attack_2_pressed.emit()
	
	if event.is_action_pressed("melee"):
		print("punch!")
		melee_pressed.emit()


func _process(delta: float):
	update_rotation(delta)


func _physics_process(delta: float):
	update_move(delta)


func update_rotation(delta):
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
	%RotationRoot.rotation_degrees.y = lerp(%RotationRoot.rotation_degrees.y, camrot_h, delta * h_acceleration)
	%Neck.rotation_degrees.x = lerp(%Neck.rotation_degrees.x, camrot_v, delta * v_acceleration)


func update_move(delta: float):
	var on_floor = is_on_floor()
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = Vector3(input_dir.x, 0, input_dir.y)
	if !using_follow_cam:
		direction = %RotationRoot.transform.basis * direction
	else:
		#var cam_forward = -camera.global_transform.basis.z
		#cam_forward = Plane(Vector3.UP).project(cam_forward).normalized()
		#direction = direction.rotated(Vector3.UP, cam_forward.angle_to(Vector3.FORWARD))
		direction = camera.global_basis * direction
	
	direction = Vector3(direction.x, 0, direction.z).normalized()
	
	if direction:
		move(direction, delta)
		#set to run animation
		if character_animator != null:
			if !(character_animator.current_animation == "Run"):
				character_animator.play("Run")
	else:
		if character_animator != null:
			if !(character_animator.current_animation == "idle"):
				character_animator.play("idle")
		if on_floor:
			slow_to_stop()
	
	if !on_floor:
		velocity.y -= gravity * delta
		
	move_and_slide()


func move(direction: Vector3, delta):
	var xz_move = accelerate_in_direction(direction, delta, speed_mult)
	velocity.x = xz_move.x
	velocity.z = xz_move.z


func accelerate_in_direction(direction: Vector3, delta: float, mult: float) -> Vector3:
	var desired_velocity: Vector3 = direction * speed * mult
	var adjusted_velocity = velocity.lerp(desired_velocity, 1.0 - exp(-acceleration * delta))
	return adjusted_velocity


func slow_to_stop():
	var xz_vel: Vector2 = Vector2(velocity.x, velocity.z)
	var velocity_mag = xz_vel.length()
	velocity_mag = move_toward(velocity_mag, 0, speed)
	xz_vel = xz_vel.normalized() * velocity_mag
	velocity.x = xz_vel.x
	velocity.z = xz_vel.y
