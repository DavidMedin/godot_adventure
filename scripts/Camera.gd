extends Camera

onready var hero = $"../hero_body"
onready var offset =  translation - hero.translation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translation = Vector3(hero.translation.x + offset.x, hero.translation.y + offset.y, hero.translation.z + offset.z)
	pass
