extends CharacterBody3D

@export var health: int = 10

const SPEED = 5.0
@export var snowballScene : PackedScene
@export var snowballSpawnPosition : Node3D

func die():
	if health <= 0:
		print("This enemy is dead!")
		
func applyFreeze():
	print("Taken freeze damage!")
		
func snowBall():
	#var snowball = snowballScene.instantiate() as Node3D 
	
	print("Snowball attack!")
	
func iceBreath():
	print("Icy breath attack!")
	
func melee():
	print("Melee attack!")
