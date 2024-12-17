extends Node3D

@export var snowballScene : PackedScene
@export var snowballSpawn : Node3D
@export var Yeti : Node3D
func _ready():
	if Yeti == null:
		print("no yeti")
		return
	Yeti.attack_1_pressed.connect(OnAttack)
	
func OnAttack():
	var snowball = snowballScene.instantiate()
	var throwSpeed = 30
	Yeti.add_sibling(snowball)
	snowball.transform = snowballSpawn.global_transform
	snowball.linear_velocity = snowballSpawn.global_transform.basis.z * -1 * throwSpeed
	print("throw!")
