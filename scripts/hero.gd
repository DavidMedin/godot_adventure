extends KinematicBody

# onready var phys = $"../"
# onready var dir_indic = $"dir_indic"
# onready var indic_offset = (translation - dir_indic.translation).distance_to(Vector3(0,0,0))

export var speed = 10
export var gravity = 9.8

var velocity = Vector3(0,0,0)

var move = Vector2(0,0)
var dir = Vector3(0,0,0) # calculated from 'move'
var right_rot = Transform().rotated(Vector3(0,1,0), -PI/2 )
var right_dir = Vector3(0,0,0)

var last_collide = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in get_tree().get_nodes_in_group("Keys"):
		x.connect("body_entered",self,"body_entered",[x])

func _input(e):
	var change = false
	if e.is_action_pressed("move_left") or e.is_action_released("move_right"):
		move.x += 1
		change = true
	if e.is_action_pressed("move_right") or e.is_action_released("move_left"):
		move.x -= 1
		change = true

	if e.is_action_pressed("move_up") or e.is_action_released("move_down"):
		move.y += 1
		change = true
	if e.is_action_pressed("move_down") or e.is_action_released("move_up"):
		move.y -= 1
		change = true
	
	if change == true:
		var norm = move.normalized()
		dir = Vector3(norm.x,dir.y,norm.y)
		right_dir = right_rot * dir



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	velocity.y -= delta * gravity

	# Get normal of last collision (if there was one)
	var normal = Vector3(0,1,0)

	var elude_margin = 0.001
	var skip = false
	if last_collide != null: 
		# if last.normal.y < -elude_margin and last.normal.y > elude_margin:
		if last_collide.normal.y > -elude_margin and last_collide.normal.y < elude_margin:
			skip = true
		else:
			normal = last_collide.normal

	# adjust user input to be aligned with normal of ground
	var direction_vel = normal.cross(right_dir)
	# var direction_vel = dir
	if skip == true:
		direction_vel = Vector3(0,0,0)

	# Sum user input (as interpreted as velocity) with accrued velocity
	var vel = (velocity + direction_vel) * speed
	#move
	move_and_slide(vel,Vector3(0,1,0), true)

	# save velocity as remainder.
	var this = get_last_slide_collision()
	if this != null:
		velocity = this.remainder
		last_collide = this

	if dir != Vector3(0,0,0):
		rotation.y = atan2(dir.x,dir.z)


func body_entered(body:Node, key:Node):
	if body==self:
		$"%inv".key = true
		key.queue_free()
