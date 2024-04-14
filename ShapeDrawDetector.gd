extends Node2D

signal drew_outside_model

@export var modelTolerance = 20
@export var CompletionTolerance = modelTolerance

var path_points_todo = Array()
var total_points = 0
var completionRate = 0

func populate_todo_points():
	path_points_todo.clear()
	for path in get_children():
		if path is Path2D:
			for p in path.curve.get_baked_points():
				path_points_todo.push_back(p)
	total_points = path_points_todo.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_todo_points()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_completion_rate():
	return completionRate

func _on_chalk_point_added(point):
	#check if the point drawn is outside area
	update_completion_rate(point)
	if not is_in_model(point):
		drew_outside_model.emit()

func is_in_model(point: Vector2) -> bool:
	var shortestDistance = null
	for path in get_children():
		if path is Path2D:
			var distanceToCurve = path.curve.get_closest_point(point).distance_to(point)
			if shortestDistance == null or distanceToCurve < shortestDistance:
				shortestDistance = distanceToCurve

	if shortestDistance < modelTolerance:
		return true

	return false

func update_completion_rate(point: Vector2) -> float:
	var q_index = 0
	while q_index < path_points_todo.size():
		if point.distance_to(path_points_todo[q_index]) < CompletionTolerance:
			path_points_todo.remove_at(q_index)
		q_index += 1

	completionRate = float(total_points - path_points_todo.size()) / float(total_points)
	return completionRate

func compute_precision() -> float:
	for path in get_children():
		if not (path is Path2D):
			continue
	return 0


func _on_chalk_cleared_chalk():
	populate_todo_points()
