extends Control

@export var tutorialStep = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Textbox02.visible=true
	$Textbox03.visible=false
	$Black.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func nextTutorialStep():
	tutorialStep += 1
	match tutorialStep:
		1:
			$Textbox02.visible=false
			$Textbox03.visible=true
			$Black.visible=false


