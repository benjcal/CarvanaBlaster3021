extends Node

export var score = 0 
export var level = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "Score %s, Level %s" % [score, level]

func _on_LineEdit_text_entered(new_text):
	$HTTPRequest.request("http://138.197.78.108:5000/add?name=%s&score=%s&level=%s" % [$LineEdit.text, score, level])
	
