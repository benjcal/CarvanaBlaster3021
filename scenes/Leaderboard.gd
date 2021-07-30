extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("https://cvnaapi.bcalderon.io")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")
	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if len(json.result) < 8:
		for i in len(json.result):
			$scores.text += "%s Level: %s Score: %s\n" % [json.result[i].name, json.result[i].level, json.result[i].score]
	else:
		for i in range(8):
			$scores.text += "%s Level: %s Score: %s\n" % [json.result[i].name, json.result[i].level, json.result[i].score]
