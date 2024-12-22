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
	
	# Set the default sound level, but only once (since this is an autolod)
	set_bus_volume(0.5, "Master")


func set_bus_volume(volume_percent: float, bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume_percent))
