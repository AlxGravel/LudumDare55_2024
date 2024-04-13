extends Sprite2D

var elapsedtime = 0

func _ready():
	modulate = Color(1,0,0,1)
	

func _process(delta):
	elapsedtime += delta
	modulate = Color((sin(elapsedtime)+1)/4,0,0,1)


