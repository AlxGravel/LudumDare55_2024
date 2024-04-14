extends Node

signal point_added(point)
signal cleared_chalk
signal left_clicked

@export var cursor_speed = 1
@export var can_draw = true
@export var lines = [Line2D.new()]


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(lines.back())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Cursor.position = (Vector2(500,300))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _input(event):
	if event is InputEventMouseMotion:
		$Cursor.position += event.relative * cursor_speed
		#confine the cursor to the viewport
		var visible_rect = get_viewport().get_visible_rect()
		$Cursor.position = $Cursor.position.clamp(visible_rect.position, visible_rect.end)
		#draw chalk
		if can_draw and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			lines.back().add_point($Cursor.position)
			point_added.emit($Cursor.global_position)


	elif event is InputEventMouseButton:
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			lines.push_back(Line2D.new())
			self.add_child(lines.back())
			left_clicked.emit()	

		if event.button_index == MOUSE_BUTTON_RIGHT:
			#clear chalk
			for line in lines:
				line.queue_free()
			lines.clear()
			lines.push_back(Line2D.new())
			self.add_child(lines.back())
			cleared_chalk.emit()
			


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
