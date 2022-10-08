extends Spatial

onready var l_door = $"l_door"
onready var r_door = $"r_door"

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open():
	var tween = create_tween().set_parallel()
	tween.tween_property(l_door,"rotation_degrees:y",85.0,1.0)#.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(r_door,"rotation_degrees:y",-85.0,1.0)#.set_ease(Tween.EASE_IN_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == "hero_body":
		if body.get_node("../inv").key == true:
			print("Entered!")
			open()
			body.get_node("../inv").key = false
