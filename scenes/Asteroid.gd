extends RigidBody2D

export (PackedScene) var Explosion

signal blowup

export var min_speed = 200
export var max_speed = 500
var min_rotation_speed = -10
var max_rotation_speed = 10
var base_rotation_speed = PI / 128
var rotation_speed = 0
var current_sprite

func _ready():
	random_type()
	random_rotation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_sprite.rotation += rotation_speed
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Asteroid_body_shape_entered(body_id, body, body_shape, local_shape):
	random_rotation()

func blowup():
	emit_signal("blowup")
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

func random_type():
	var rand = rand_range(1, 100)
	$StandardSprite.hide()
	$Nixon1.hide()
	$Nixon2.hide()
	$NixonRoid.hide()
	$CollisionShape2D.shape.radius = 64
	
	if rand > 95:
		current_sprite = $NixonRoid
	elif rand > 85:
		current_sprite = $Nixon1
	elif rand > 75:
		current_sprite = $Nixon2
	else:
		current_sprite = $StandardSprite
		$CollisionShape2D.shape.radius = 30
	
	current_sprite.show()

