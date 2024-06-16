extends Sprite2D
@export_category("STATS")
@export var Health : int = 10#

#Global variables
var NEW_POSITION

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_meta("frog_count"):
		get_parent().frog_count += 1
	
	
	calculateNextRandCoord()
	
func calculateNextRandCoord():
	var isFrogOnScreen = false
	var xOffset
	var yOffset
	var largestX = get_viewport_rect().end.x - 100
	var largestY = get_viewport_rect().end.y - 100 #the bounce animation takes it off screen, we need to minus the max bounce height from this
	
	#idle for a random time
	randomize()
	await get_tree().create_timer(randf_range(2,4)).timeout
	
	#calculate the new movement position
	#and check that the new frog coords are on the screen
	while isFrogOnScreen == false:
		xOffset = randi_range(-100, 100)
		yOffset = randi_range(-100, 100)
		NEW_POSITION = Vector2(self.position.x + xOffset, self.position.y + yOffset)
		if NEW_POSITION.x < largestX and NEW_POSITION.x > 0 and NEW_POSITION.y < largestY and NEW_POSITION.y > 0:
			isFrogOnScreen = true
	
	#flip frog if new movement direction
	if %AnimatedSprite2D.flip_h == true:
		if NEW_POSITION.x > position.x:
			%AnimatedSprite2D.flip_h = false
	else:
		if NEW_POSITION.x < position.x:
			%AnimatedSprite2D.flip_h = true
	
	#begin hopping
	%AnimatedSprite2D.play("hop")
	
func frogRandomMove():
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", NEW_POSITION, (0.6))

	await tween.finished
	%AnimatedSprite2D.play("Idle")
	
	calculateNextRandCoord()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animated_sprite_2d_frame_changed():
	#only want to start moving when hopping animation is on frame 3
	if %AnimatedSprite2D.get_frame() == 3 and %AnimatedSprite2D.animation == "hop":
		frogRandomMove()
