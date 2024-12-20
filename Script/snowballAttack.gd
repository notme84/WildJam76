extends Node3D

@export var snowballScene : PackedScene
#@export var snowballSpawn : Node3D
@export var Yeti : Node3D
@export var min_throw_speed: float = 5
@export var max_throw_speed: float = 30
@export var max_strength_time: float = 1.0
#@export var throwSpeed : float = 30

var tween: Tween = null


func _ready():
	if Yeti == null:
		print("no yeti")
		return
	Yeti.attack_1_pressed.connect(OnAttack_pressed)
	Yeti.attack_1_released.connect(OnAttack_released)


func OnAttack_pressed():
	if max_strength_time <= 0:
		OnAttack()
		return
	
	if tween != null && tween.is_running(): return
	
	tween = create_tween()
	tween.tween_interval(max_strength_time)
	tween.tween_callback(kill_tween)


func kill_tween():
	if tween == null: return
	tween.kill()
	tween = null


func OnAttack_released():
	OnAttack()
	kill_tween()


func OnAttack():
	var snowball = snowballScene.instantiate()
	
	#make snowball ignore hitboxes of thrower
	snowball.source = Yeti
	
	var throwSpeed = compute_throw_speed()
	
	Yeti.add_sibling(snowball)
	snowball.transform = global_transform
	var thrower_velocity = Yeti.velocity
	var throw_velocity = global_transform.basis.z * -1 * throwSpeed
	if throw_velocity.dot(thrower_velocity) > 0:
		throw_velocity = throw_velocity + thrower_velocity
	snowball.linear_velocity = throw_velocity
	
	$AudioStreamPlayer.stream = SoundLibrary.get_throw_sound()
	$AudioStreamPlayer.play()


func compute_throw_speed() -> float:
	if tween == null || !tween.is_running():
		return max_throw_speed
	
	return max(min_throw_speed, (tween.get_total_elapsed_time() / max_strength_time) * max_throw_speed)
