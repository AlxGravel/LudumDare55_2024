extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.use_accumulated_input = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://UI/MainMenu.tscn")



func _on_shape_draw_detector_drew_outside_model():
	$Chalk.can_draw = false

func _on_chalk_cleared_chalk():
	$Chalk.can_draw = true
	$BigCandleL.playburning()
	$BigCandleR.playburning()
