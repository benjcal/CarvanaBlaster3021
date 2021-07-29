extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var health_points = 100;
var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bar/HealthGauge.set_value(health_points)
	pass # Replace with function body.

func set_health(health):
	if (health < 0):
		health = 0

	$Bar/HealthGauge.set_value(health)

func destroyed_asteroid():
	score += 100
	$Score.text = score

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
