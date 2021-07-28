extends Node

export (PackedScene) var Asteroid
export (PackedScene) var Hauler

var hauler
var hauler_speed = 400
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func new_game():
	$StartTimer.start()
	
	hauler = Hauler.instance()
	add_child(hauler)

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * hauler_speed

	hauler.position += velocity * delta

func _on_StartTimer_timeout():
	$AsteroidSpawnTimer.start()
	# Replace with function body.


func _on_AsteroidSpawnTimer_timeout():
	 # Choose a random location on Path2D.
	$AsteroidPath/AsteroidSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var roid = Asteroid.instance()
	add_child(roid)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $AsteroidPath/AsteroidSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	roid.position = $AsteroidPath/AsteroidSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	roid.rotation = direction
	# Set the velocity (speed & direction).
	roid.linear_velocity = Vector2(rand_range(roid.min_speed, roid.max_speed), 0)
	roid.linear_velocity = roid.linear_velocity.rotated(direction)
	 # Replace with function body.
