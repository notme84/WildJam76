extends CharacterBody3D

@export var health: int = 10

const SPEED = 5.0

func die():
	if health <= 0:
		print("This enemy is dead!")
		
func applyFreeze():
	print("Taken freeze damage!")
		
func snowBall():
	print("Snowball attack!")
	
func iceBreath():
	print("Icy breath attack!")
	
func melee():
	print("Melee attack!")
