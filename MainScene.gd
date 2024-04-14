extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.use_accumulated_input = false
	$Chalk.can_draw = false
	$MainTutorial.visible = true


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
	if $MainTutorial != null:
		$MainTutorial.queue_free()

func _on_chalk_left_clicked():
	if $MainTutorial != null:
		$MainTutorial.nextTutorialStep()
		if $MainTutorial.tutorialStep == 1:
			$Chalk.can_draw = true



func _on_chalk_point_added(point):
	if $MainTutorial != null:
		$MainTutorial.nextTutorialStep()
	if $ShapeDrawDetector.get_completion_rate() >= 1:
		$CanvasLayer/UWonText.visible = true
		$Chalk.can_draw = false


