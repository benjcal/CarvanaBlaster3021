extends CPUParticles2D

var timeout = 0

func start():
	emitting = true
	$Smoke.emitting = true


func _process(delta):
	timeout += delta
	if timeout > 700:
		queue_free()
