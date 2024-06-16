extends Sprite2D
@export_category("STATS")
@export var Health : int = 10#


var direction = 1
var speed = 100
var hopFrame4 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_meta("frog_count"):
		get_parent().frog_count += 1
	
	
	frogRandomMove()
	pass # Replace with function body.
	

func frogRandomMove():
	
	randomize()
	await get_tree().create_timer(randf_range(2,4)).timeout
	
	var isFrogOnScreen = false
	var newPosition
	var xOffset
	var yOffset
	var largestX = get_viewport_rect().end.x - 100
	var largestY = get_viewport_rect().end.y - 100 #the bounce animation takes it off screen, we need to minus the max bounce height from this
	
	#check that the new frog coords are on the screen
	while isFrogOnScreen == false:
		xOffset = randi_range(-100, 100)
		yOffset = randi_range(-100, 100)
		newPosition = Vector2(self.position.x + xOffset, self.position.y + yOffset)
		if newPosition.x < largestX and newPosition.x > 0 and newPosition.y < largestY and newPosition.y > 0:
			isFrogOnScreen = true
	
	
	
	
	#var x_position = randi_range(0, get_viewport_rect().end.x)
	#var y_position = randi_range(0, get_viewport_rect().end.y)
	#position = Vector2(x_position, y_position) # greyed out because I don't want a jump to the new position


	
	
	%AnimatedSprite2D.play("hop")
	while hopFrame4 != true:
		print("NotHopping")
	print("Hopping")
	hopFrame4 = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", newPosition, 1)
	#Points Right 
	#if flipped == false:
		#if newPosition.x < position.x :
			#flip frog (Point Left)
	if %AnimatedSprite2D.flip_h == true:
		if newPosition.x > position.x:
			%AnimatedSprite2D.flip_h = false
	else:
		if newPosition.x < position.x:
			%AnimatedSprite2D.flip_h = true
	
	await tween.finished
	%AnimatedSprite2D.play("Idle")
	#while(not in boundary)
		#randomly select a direction
		#add a set move amount to that direction
		#check if its in the boundary
	#move the sprite
	
	frogRandomMove()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(%AnimatedSprite2D.get_frame())
	  # Calculate movement step for this frame
	#var move_step = direction * speed * delta
	## Update the node's position
	#position.x += move_step
	pass


func _on_animated_sprite_2d_frame_changed():
	print()
	if %AnimatedSprite2D.get_frame() == 4:
		hopFrame4 = true
