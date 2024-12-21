extends Node3D

@export var target: Node3D
@export var follow_distance: float = 10.0
@export_flags_3d_physics var surface_layers: int = ~0


func _ready():
	if target == null:
		target = get_parent()


func _process(delta):
	if target == null:
		printerr("FOLLOW CAM HAS NO TARGET")
		return
		
	#move to position behind target
	var target_pos: Vector3 = target.global_position + target.global_basis.z.normalized() * follow_distance
	
	#check of something between camera and player and move target pos closer
	var ray_origin = target.global_position
	var ray_end = target_pos
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, surface_layers)
	var collision = get_world_3d().direct_space_state.intersect_ray(query)
	if !collision.is_empty(): #HIT SOMETHING
		target_pos = collision["position"]
	
	global_position = target_pos
	
	var dir = (target.global_position - global_position).normalized()
	if dir != Vector3.UP:
		look_at(target.global_position)
