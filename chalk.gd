extends Node

signal point_added(point)
signal cleared_chalk
signal left_clicked

@export var cursor_speed = 1
@export var can_draw = true
@export var lines = [Line2D.new()]
var must_make_a_mess = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(lines.back())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Cursor.position = (Vector2(500,300))

var mess_timer = null
func make_a_mess():
	remove_mess_timer()
	must_make_a_mess = true
	can_draw = false
	var timer = Timer.new()
	timer.wait_time = 0.4
	timer.one_shot = true
	mess_timer = timer
	self.add_child(mess_timer)
	mess_timer.start()
	mess_timer.timeout.connect(stop_mess)


func remove_mess_timer():
	if mess_timer == null:
		return
	stop_mess()

func stop_mess():
	mess_timer.timeout.disconnect(stop_mess)
	mess_timer.queue_free()
	mess_timer = null
	must_make_a_mess = false
	remove_mess_timer()

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
		if must_make_a_mess:
			lines.back().add_point($Cursor.position)
		if can_draw and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			lines.back().add_point($Cursor.position)
			point_added.emit($Cursor.global_position)



	elif event is InputEventMouseButton:
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			new_chalk_line()
			left_clicked.emit()

		if event.button_index == MOUSE_BUTTON_RIGHT:
			#clear chalk
			for line in lines:
				line.queue_free()
			lines.clear()
			new_chalk_line()
			remove_mess_timer()
			cleared_chalk.emit()

func new_chalk_line():
	var newline = Line2D.new()
	lines.push_back(newline)
	self.add_child(lines.back())

func _on_area_2d_area_entered(area):
	pass # Replace with function body.
