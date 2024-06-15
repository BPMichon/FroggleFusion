extends Sprite2D
@export_category("STATS")
@export var Health : int = 10#


var direction = 1
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_meta("frog_count"):
		get_parent().frog_count += 1
	
	frogRandomMove()
	pass # Replace with function body.
	
func frogRandomMove():
	randomize()
	await get_tree().create_timer(randf_range(0.5,2)).timeout

	var x_position = randi_range(0, get_viewport_rect().end.x)
	var y_position = randi_range(0, get_viewport_rect().end.y)
	#position = Vector2(x_position, y_position) # greyed out because I don't want a jump to the new position


	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(x_position, y_position), 1)
	#tween.interpolate_property(self, "position",
	#position, Vector2(x_position, y_position), 1,
	#Tween.TRANS_EXPO, Tween.EASE_OUT)

	#tween.start()
	await tween.finished
	#tween.tween_callback(queue_free())
	#while(not in boundary)
		#randomly select a direction
		#add a set move amount to that direction
		#check if its in the boundary
	#move the sprite
	
	frogRandomMove()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	  # Calculate movement step for this frame
	#var move_step = direction * speed * delta
	## Update the node's position
	#position.x += move_step
	pass
