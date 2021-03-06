extends Node

export var score = 0 
export var level = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "Score %s Level %s" % [score, level]
	$BGMusic.play()

func _on_LineEdit_text_entered(new_text):
	$Select.play()
	$HTTPRequest.request("https://cvnaapi.bcalderon.io/add?name=%s&score=%s&level=%s" % [$LineEdit.text, score, level])


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	get_tree().change_scene("res://scenes/MainMenu.tscn")
