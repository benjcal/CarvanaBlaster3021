extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal damage_taken
var invincible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "straight"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_animation(left, up, right, down):
	if up:
		if left:
			$AnimatedSprite.animation = "up"
		elif right:
			$AnimatedSprite.animation = "up"
		else:
			$AnimatedSprite.animation = "up"
	elif down:
		if left:
			$AnimatedSprite.animation = "down"
		elif right:
			$AnimatedSprite.animation = "down"
		else:
			$AnimatedSprite.animation = "down"
	elif right:
		$AnimatedSprite.animation = "straight"
	elif left:
		$AnimatedSprite.animation = "straight"
	else:
		$AnimatedSprite.animation = "straight"
		
	




func up():
	$AnimatedSprite.animation = "up"

func down():
	$AnimatedSprite.animation = "down"

func straight():
	$AnimatedSprite.animation = "straight"

func _on_Hauler_body_entered(body):
	if "Asteroid" in body.name:
		body.blowup()
		
	if (invincible == false):
		$InvicibilityTimer.start()
		emit_signal("damage_taken")
		invincible = true

func _on_InvicibilityTimer_timeout():
	invincible = false

