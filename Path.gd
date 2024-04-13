extends Node2D

const speed = 100
const ZoneLength = 100

var line;
# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Path2D/ZoneStartFollow.progress = ZoneLength
	line = Line2D.new()
	line.default_color = Color(1,1,1,1)
	line.width = 1
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.transform = $CanvasLayer/Path2D.transform
	self.add_child(line)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = delta * speed
	$CanvasLayer/Path2D/SpriteFollow.progress += movement
	$CanvasLayer/Path2D/ZoneStartFollow.progress += 0 if $CanvasLayer/Path2D/SpriteFollow.progress < ZoneLength / 2 else movement
	$CanvasLayer/Path2D/ZoneEndFollow.progress += 0 if $CanvasLayer/Path2D/SpriteFollow.progress < ZoneLength / 2 else movement

	line.clear_points()
	var line_points = $CanvasLayer/Path2D.curve.get_baked_points()
	line_points = line_points.slice(round($CanvasLayer/Path2D/ZoneEndFollow.progress_ratio * line_points.size()), \
					  				round($CanvasLayer/Path2D/ZoneStartFollow.progress_ratio * line_points.size()))
	for p in line_points:
		line.add_point(p)
