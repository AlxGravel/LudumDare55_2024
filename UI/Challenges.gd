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
			$AnimationPlayer.play("FadeInChallenge1")
		2:
			visible_challenge = $Challenge2
			$AnimationPlayer.play("FadeInChallenge2")
		3:
			visible_challenge = $Challenge3
			$AnimationPlayer.play("FadeInChallenge3")
		4:
			visible_challenge = $Challenge4
			$AnimationPlayer.play("FadeInChallenge4")
	if visible_challenge != null:
		visible_challenge.visible = true


func hide_all_challenges():
	if visible_challenge != null:
		visible_challenge.visible = false
