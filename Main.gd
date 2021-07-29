extends Node

export (PackedScene) var Asteroid
export (PackedScene) var Hauler
export (PackedScene) var Laser

var hauler
var hauler_speed = 400
var hauler_health = 100

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Laser.stream.loop = false
	$Boom.stream.loop = false
	randomize()
	new_game()

func new_game():
	$AsteroidSpawnTimer.start()
	
	hauler = Hauler.instance()
	hauler.position = Vector2(150, 300)
	hauler.connect("damage_taken", self, "on_damage_taken")
	add_child(hauler)

func _process(delta):
	# move hauler
	var velocity = Vector2()
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
	hauler.position.x = clamp(hauler.position.x, 0, 1024)
	hauler.position.y = clamp(hauler.position.y, 0, 600)	
	
	# fire laser
	if Input.is_action_just_pressed("ui_accept"):	
		$Laser.play()
		var laser = Laser.instance()
		add_child(laser)
		laser.position = Vector2(hauler.position.x + 120, hauler.position.y) 
		
		laser.linear_velocity = Vector2(1500, 0)


func _on_AsteroidSpawnTimer_timeout():
	 # Choose a random location on Path2D.
	$AsteroidPath/AsteroidSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var roid = Asteroid.instance()
	roid.connect("blowup", self, "on_Asteroid_blowup")
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
	
func on_damage_taken():
	hauler_health -= 20
	$HUD.set_health(hauler_health)

func on_Asteroid_blowup():
	$Boom.play()
	score += 1
	$HUD/Score.text = "Score: %s" % score
