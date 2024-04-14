extends Control

var visible_challenge = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_challenge(index: int):
	if visible_challenge != null:
		visible_challenge.visible = false
	match index:
		1:
			visible_challenge = $Challenge1
		2:
			visible_challenge = $Challenge2
	if visible_challenge != null:
		visible_challenge.visible = true

func hide_all_challenges():
	if visible_challenge != null:
		visible_challenge.visible = false
