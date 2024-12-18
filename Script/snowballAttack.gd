extends Node3D

@export var snowballScene : PackedScene
#@export var snowballSpawn : Node3D
@export var Yeti : Node3D
@export var throwSpeed : float = 30


func _ready():
	if Yeti == null:
		print("no yeti")
		return
	Yeti.attack_1_pressed.connect(OnAttack)
	
func OnAttack():
	var snowball = snowballScene.instantiate()
	
	#make snowball ignore hitboxes of thrower
	snowball.source = Yeti
	
	Yeti.add_sibling(snowball)
	snowball.transform = global_transform
	snowball.linear_velocity = global_transform.basis.z * -1 * throwSpeed
	print("throw!")
