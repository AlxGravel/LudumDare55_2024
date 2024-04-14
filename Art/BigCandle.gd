extends Node2D

signal candles_finished_burning

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playburning():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Melting")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Melting":
		candles_finished_burning.emit()
