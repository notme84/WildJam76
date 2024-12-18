extends Node3D

@onready var health_component: HealthComponent = $HealthComponent


func _ready():
	health_component.died.connect(on_died)


func on_died():
	queue_free()
