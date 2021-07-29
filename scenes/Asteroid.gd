extends RigidBody2D

export (PackedScene) var Explosion

export var min_speed = 200
export var max_speed = 500
var min_rotation_speed = -10
var max_rotation_speed = 10
var base_rotation_speed = PI / 128
var rotation_speed = 0

func _ready():
	random_rotation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.rotation += rotation_speed
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Asteroid_body_shape_entered(body_id, body, body_shape, local_shape):
	random_rotation()

func blowup():
	var e = Explosion.instance()
	get_parent().add_child(e)
	e.position = position
	e.start()
	queue_free()

func random_rotation():
	rotation_speed = rand_range(min_rotation_speed, max_rotation_speed) * base_rotation_speed

func _on_Asteroid_body_entered(body):
	if body.name.find("Laser", 0) > 0:
		blowup()

