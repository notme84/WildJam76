extends Area3D

@export var health_component: HealthComponent


func _ready():
	body_entered.connect(on_body_entered)
	area_entered.connect(on_area_entered)


func on_body_entered(body: Node3D):
	#TODO set up attacks to have some sort of damage amount parameter
	if health_component == null:
		printerr("HITBOX HAS NO REFERENCE TO A HEALTH COMPONENT")
		return
	
	health_component.take_damage(10)


func on_area_entered(area: Area3D):
	if health_component == null:
		printerr("HITBOX HAS NO REFERENCE TO A HEALTH COMPONENT")
		return
	
	health_component.take_damage(10)
