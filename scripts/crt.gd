extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var r_offset = 0.0 setget r_set

func r_set(val):
	r_offset = val
	material.set_shader_param("r_offset",r_offset)
# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("r_offset",r_offset)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
