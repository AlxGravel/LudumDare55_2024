extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop()
	$Aura.visible = false
	$Flame.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playBurning():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("FlameMovement")
	$Aura.visible = true
	$Flame.visible = true
	
