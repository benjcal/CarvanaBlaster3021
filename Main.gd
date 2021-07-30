extends Node

export (PackedScene) var Asteroid
export (PackedScene) var Hauler
export (PackedScene) var Laser
export (PackedScene) var Explosion
export (PackedScene) var WD40
export (PackedScene) var GameOver

var hauler
var hauler_speed = 400
var hauler_health = 100

var score = 0

var dificulty_time = 0
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Laser.stream.loop = false
	$Boom.stream.loop = false
	randomize()
	new_game()


func new_game():
	$AsteroidSpawnTimer.start()
	$CollectableTimer.start()
	
	hauler = Hauler.instance()
	hauler.position = Vector2(150, 300)
	hauler.connect("damage_taken", self, "on_damage_taken")
	add_child(hauler)

func _process(delta):
	dificulty_time += delta
	
	if dificulty_time > 10:
		dificulty_time = 0
		level += 1
		$HUD.set_level(level)
		
		$AsteroidSpawnTimer.wait_time = $AsteroidSpawnTimer.wait_time/1.5
		print($AsteroidSpawnTimer.wait_time)
	
	
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
	hauler_health -= 25
	
	
	if hauler_health <= 0:
		var e = Explosion.instance()
		add_child(e)
		e.position = hauler.position
		hauler.hide()
		get_tree().paused = true
	
		$Boom.play()	
		e.pause_mode = Node.PAUSE_MODE_PROCESS
		e.scale = Vector2(2.5,2.5)
		e.start()
		$GameOverTimer.start()
		
		
	$HUD.set_health(hauler_health)

func on_Asteroid_blowup():
	$Boom.play()
	score += 1
	$HUD/Score.text = "Score: %s" % score

func _on_CollectableTimer_timeout():
	var rand = rand_range(1, 100)
	
	if (rand > 75):
		$AsteroidPath/AsteroidSpawnLocation.offset = randi()
		var wd = WD40.instance()
		add_child(wd)
		var direction = $AsteroidPath/AsteroidSpawnLocation.rotation + PI / 2
		wd.position = $AsteroidPath/AsteroidSpawnLocation.position
		wd.connect("collect", self, "on_wd_collect")

func on_wd_collect():
	hauler_health += 20
	
	if (hauler_health > 100):
		hauler_health = 100
	
	$HUD.set_health(hauler_health)

func _on_GameOverTimer_timeout():
	get_tree().paused = false
	var res = load("res://scenes/GameOver.tscn")
	var go = res.instance()
	go.score = score
	go.level = level
	
	var ps = PackedScene.new()
	ps.pack(go)
	
	get_tree().change_scene_to(ps)
