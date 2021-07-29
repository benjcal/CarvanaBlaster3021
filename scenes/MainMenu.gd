extends Node

var selected = 0

const selected_color = Color(1,1,1)
const default_color = Color(0.5,0.5,0.5)

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		selected += 1
	if Input.is_action_just_pressed("ui_up"):
		selected -= 1
	if Input.is_action_just_pressed("ui_accept"):
		if selected == 0:
			get_tree().change_scene("res://Main.tscn")
		if selected == 1:
			get_tree().change_scene("res://scenes/Leaderboard.tscn")
	

	if selected > 1:
		selected -= 1
	if selected < 0:
		selected += 1
		
	if selected == 0:
		$Start.set("custom_colors/font_color",selected_color)
		$Leaderboard.set("custom_colors/font_color",default_color)
	if selected == 1:
		$Start.set("custom_colors/font_color",default_color)	
		$Leaderboard.set("custom_colors/font_color",selected_color)
