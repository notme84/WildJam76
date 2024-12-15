extends CharacterBody3D

@onready var camera: Camera3D = %Camera3D

@export var speed: float = 10
@export var acceleration: float = 5

var camrot_h: float
var camrot_v: float
@export var cam_v_min: float = -80
@export var cam_v_max: float = 80
var h_acceleration: float = 10
var v_acceleration: float = 10


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			camrot_h -= event.relative.x * Settings.mouse_sensitivity_x
			camrot_v -= event.relative.y * Settings.mouse_sensitivity_y
	
	if event.is_action_pressed("camera_mode"):
		#SWITCH BETWEEN FIRST AND THIRD PERSON
		if camera.get_parent() == %HeadCameraMount:
			camera.reparent(%FollowCameraHousing)
		else: camera.reparent(%HeadCameraMount)
		camera.position = Vector3.ZERO
		camera.rotation = Vector3.ZERO


func _process(delta: float):
	update_rotation(delta)


func _physics_process(delta: float):
	pass


func update_rotation(delta):
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
	%RotationRoot.rotation_degrees.y = lerp(%RotationRoot.rotation_degrees.y, camrot_h, delta * h_acceleration)
	%Neck.rotation_degrees.x = lerp(%Neck.rotation_degrees.x, camrot_v, delta * v_acceleration)
