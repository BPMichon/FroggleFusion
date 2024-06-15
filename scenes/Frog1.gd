extends Sprite2D
@export_category("STATS")
@export var Health : int = 10#


var direction = 1
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_meta("frog_count"):
		get_parent().frog_count += 1
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	  # Calculate movement step for this frame
	var move_step = direction * speed * delta
	# Update the node's position
	position.x += move_step
	pass
