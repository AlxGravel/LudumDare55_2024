extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.use_accumulated_input = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")

