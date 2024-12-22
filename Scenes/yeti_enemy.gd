extends CharacterBody3D
@onready var health_component: HealthComponent = $HealthComponent
@onready var animation_player := $yeti/Animation_modified


func _ready():
	health_component.died.connect(on_died)
	
	animation_player.play("idle")


func on_died():
	queue_free()
