extends Node
class_name HealthComponent

signal health_changed(new_health: float)
signal damaged(amount: float)
signal healed(amount: float)
signal died

@export var max_health: float = 100

var health: float


func _ready():
	health = max_health


func take_damage(damage: float):
	print(get_parent().name + " taking " + str(damage) + " damage")
	
	health -= damage
	if damage < 0: #healing
		healed.emit(-damage)
		if health > max_health:
			health = max_health
			#TODO if you wanna overcharge health, do it here
	elif damage > 0:
		damaged.emit(damage)
		if health <= 0:
			health = 0
			died.emit()
	else:
		print(get_parent().name + " JUST GOT DAMAGED FOR 0. weird.")
		
	health_changed.emit(health)
