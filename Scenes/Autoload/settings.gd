extends Node

@export var default_mouse_sensitivity_x: float = 1.0
@export var default_mouse_sensitivity_y: float = 1.0
@export var default_invert_y_look: bool = false

var mouse_sensitivity_x : float
var mouse_sensitivity_y : float
var invert_y_look: bool

var joystick_mult: float = 2


func _ready():
	#TODO set up player prefs to load settings
	mouse_sensitivity_x = default_mouse_sensitivity_x
	mouse_sensitivity_y = default_mouse_sensitivity_y
	invert_y_look = default_invert_y_look
