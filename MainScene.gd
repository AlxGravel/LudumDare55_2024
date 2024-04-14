extends Label

var slowdown_called_flag = false
var polarityrev_called_flag = false

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
	$Chalk.make_a_mess()
	$FailedMsg.show_msg()
	$Challenges.hide_all_challenges()



func _on_chalk_cleared_chalk():
	slowdown_called_flag = false
	polarityrev_called_flag = false
	$Chalk.can_draw = true
	$Chalk.cursor_speed = 1
	$BigCandleL.playburning()
	$BigCandleR.playburning()
	$FailedMsg.hide_msg()
	for candle in $SmallCandlesPositionned.get_children():
		candle.playBurning()
	if $MainTutorial != null:
		$MainTutorial.visible = false

func _on_chalk_left_clicked():
	if $MainTutorial != null:
		$MainTutorial.nextTutorialStep()
		if $MainTutorial.tutorialStep == 1:
			$Chalk.can_draw = true



func _on_chalk_point_added(point):
	if $MainTutorial != null:
		$MainTutorial.nextTutorialStep()

	var completion_rate = $ShapeDrawDetector.get_completion_rate()
	if completion_rate >= 1:
		$CanvasLayer/UWonText.visible = true
		$Chalk.can_draw = false
	elif completion_rate > 0.5:
		polarityrev()
	elif completion_rate > 0.3:
		slowdown()


func slowdown():
	if slowdown_called_flag:
		return
	slowdown_called_flag = true
	$Challenges.show_challenge(1)
	$Chalk.cursor_speed = 0.2
	var timer = Timer.new()
	timer.wait_time = 5
	timer.one_shot = true
	self.add_child(timer)
	timer.start()
	timer.timeout.connect(slowdownImpl)


func slowdownImpl():
	$Challenges.hide_all_challenges()


func polarityrev():
	if polarityrev_called_flag:
		return
	polarityrev_called_flag = true
	$Challenges.show_challenge(2)
	$Chalk.cursor_speed *= -1
	$Chalk.left_hand()
	var timer = Timer.new()
	timer.wait_time = 5
	timer.one_shot = true
	self.add_child(timer)
	timer.start()
	timer.timeout.connect(polarityrevImpl)


func polarityrevImpl():

	$Challenges.hide_all_challenges()
