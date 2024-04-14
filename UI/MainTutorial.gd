extends Control

var tutorialStep = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Textbox01.visible=true
	$Textbox02.visible=false
	$Textbox03.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func nextTutorialStep():
	tutorialStep += 1
	match tutorialStep: 
		1: 
			$Textbox01.visible=false
			$Textbox02.visible=true
		2:
			$Textbox02.visible=false
			$Textbox03.visible=true
			

