extends Node2D

signal drew_outside_model

@export var modelTolerance = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var drawn_points = Array()
func _on_chalk_point_added(point):
	#check if the point drawn is outside area
	drawn_points.push_back(point)
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
