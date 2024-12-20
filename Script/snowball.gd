extends RigidBody3D

@export var impact_scene: PackedScene
@export_flags_3d_physics var surface_layers: int = ~0

var source: Node3D


func _physics_process(delta):
	var ray_origin = global_position
	var ray_end = ray_origin + linear_velocity * delta
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, surface_layers)
	query.collide_with_areas = true
	var collision = get_world_3d().direct_space_state.intersect_ray(query)
	var collider: Node3D = null
	if !collision.is_empty():
		impact(collision)


func impact(collision):
	var collider = collision["collider"]
	if collider is Hitbox:
		collider.take_hit()
	var pos = collision["position"]
	#var normal = collision["normal"]
	print("SNOWBALL HAS IMPACTED " + collider.name + " AT " + str(pos))
	do_impact_effects(pos)
	queue_free()


func get_source():
	return source


func hit(hit_object):
	print("snowball hit " + hit_object.name)
	#TODO make hit impact sound, particle effect at hit point
	do_impact_effects(global_position)
	
	queue_free()


func do_impact_effects(pos: Vector3):
	var impact = impact_scene.instantiate()
	impact.position = pos
	add_sibling(impact)


func _on_timer_timeout():
	print("removing snowball")
	queue_free()
