extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func thunderAnim():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Flash")
