extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal damage_taken

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hauler_body_entered(body):
	emit_signal("damage_taken")
	$CollisionShape2D.set_deferred("disabled", true)
