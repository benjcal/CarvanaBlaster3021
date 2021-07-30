extends Area2D

export (PackedScene) var Explosion

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal collect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= 100 * delta

func _on_WD40_area_entered(area):
	if (area.get_name() == "Hauler"):
		emit_signal("collect")
		queue_free()
		
	print(area.get_name())

func blowup():
	emit_signal("blowup")
	var e = Explosion.instance()
	get_parent().add_child(e)
	e.position = position
	e.start()
	
	queue_free()

func _on_WD40_body_entered(body):
	print(body.get_name())
	
	if ("Laser" in body.get_name()):
		blowup()
