extends Node2D

signal drew_outside_model

@export var modelTolerance = 20
@export var CompletionTolerance = modelTolerance

var drawn_points_cache = Array()
var completed_points = 0
var total_points = 0
var completionRate = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for path in get_children():
		if path is Path2D:
			total_points += path.curve.get_baked_points().size();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_chalk_point_added(point):
	#check if the point drawn is outside area
	update_completion_rate(point)
	drawn_points_cache.push_back(point)
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
	for path in get_children():
		if not path is Path2D:
			continue

		for q_index in drawn_points_cache.size():
			for p in path.curve.get_baked_points():
				if p.distance_to(drawn_points_cache[q_index]) < CompletionTolerance:
					completed_points += 1
					drawn_points_cache.remove_at(q_index)
					break
	completionRate = float(completed_points) / float(total_points)
	return completionRate
