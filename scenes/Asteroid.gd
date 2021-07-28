extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2

# var b = "text"
export var min_speed = 200
export var max_speed = 500
var min_rotation_speed = -10
var max_rotation_speed = 10
var base_rotation_speed = PI / 128
var rotation_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	random_rotation()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.rotation += rotation_speed
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # Replace with function body.

func _on_Asteroid_body_shape_entered(body_id, body, body_shape, local_shape):
	random_rotation()
	pass # Replace with function body.

func random_rotation():
	rotation_speed = rand_range(min_rotation_speed, max_rotation_speed) * base_rotation_speed
