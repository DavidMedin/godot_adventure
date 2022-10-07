extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var r_offset = 0.0 setget r_set
export var extra = 0.0 setget extra_set

func r_set(val):
	r_offset = val
	material.set_shader_param("r_offset",r_offset)

func extra_set(val):
	extra = val
	material.set_shader_param("extra",extra)

# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("r_offset",r_offset)
	material.set_shader_param("extra",extra)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
