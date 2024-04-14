extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	randomize()



func _on_play_pressed():
	get_tree().change_scene_to_file("res://MainScene.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://UI/Credits.tscn")
