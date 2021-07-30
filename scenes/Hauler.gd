extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal damage_taken
var invincible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hauler_body_entered(body):
	if body.name.find("Asteroid", 0) > 0:
		body.blowup()
		
	if (invincible == false):
		$InvicibilityTimer.start()
		emit_signal("damage_taken")
		invincible = true

func _on_InvicibilityTimer_timeout():
	invincible = false

