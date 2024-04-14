extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var current_msg
func show_msg():
	current_msg = $Msg1
	$Msg1.visible = true

func hide_msg():
	if current_msg != null:
		current_msg.visible = false
		current_msg = null
