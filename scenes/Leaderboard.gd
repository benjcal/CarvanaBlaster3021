extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("http://138.197.78.108:5000")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if len(json.result) < 8:
		for i in len(json.result):
			$scores.text += "%s %s\n" % [json.result[i].name, json.result[i].score]
	else:
		for i in range(8):
			$scores.text += "%s %s\n" % [json.result[i].name, json.result[i].score]
