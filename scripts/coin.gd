extends Area

var top = Vector3(0,1,0)
var bottom = Vector3(0,-1,0)
export var trans_speed = 2
onready var trans_tween = null

var rot_speed = PI/2


# Called when the node enters the scene tree for the first time.
func _ready():
	trans_tween = create_tween()
	trans_tween.tween_property($".","translation",translation+top,trans_speed).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	trans_tween.tween_property($".","translation",translation+bottom,trans_speed).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	trans_tween.set_loops()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.y += rot_speed * delta
