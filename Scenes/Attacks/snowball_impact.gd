extends AudioStreamPlayer3D

func _ready():
	$GPUParticles3D.finished.connect(kill)
	$GPUParticles3D.emitting = true


func kill():
	queue_free()
