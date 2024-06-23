extends AnimatedSprite2D

class_name FrogClass

#Define All Children Components
@onready var Collision = %Collision
@onready var ScienceSpawn = %ScienceSpawn

#Variables Specific to Frog
@export var frogType: FrogGlobals.FROG_TYPES
@export var DRAGGING = false
@export var NEW_POSITION : Vector2

func WriteName():
	print("Frog Class")
	
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
	if flip_h == true:
		if NEW_POSITION.x > position.x:
			flip_h = false
	else:
		if NEW_POSITION.x < position.x:
			flip_h = true
	
	#begin hopping
	%AnimatedSprite2D.play("hop")
func frogRandomMove():
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", NEW_POSITION, (0.6))

	await tween.finished
	%AnimatedSprite2D.play("Idle")
	
	calculateNextRandCoord()

# Adds a number to the Global Data
func updateFrogCount(Amount):
	
	# The way we handle updating User Interface Could be Changed
	# Instead of changing one variable call a global method
	# Which Updates the whole User Interface Screen
	
	FrogGlobals.FROG_DATA[frogType]["amount"] += 1
	var Destination = get_tree().get_nodes_in_group(str(frogType))
	Destination[0].UpdateFrog(frogType)
	
# Frog turns white before returning to normal Colour
func flashFrog():
	## Change Function to set variable Timer?
	var tween1 = get_tree().create_tween()
	tween1.tween_property(%AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
	
func _ready():
	#Starts Science SpawnTimer
	ScienceSpawn.start()
	
func _process(_delta):
	
	if Collision.MOUSE_IN  and Input.is_action_just_pressed("Click"):
		%ClickTimer.start(0.2)
	if Collision.MOUSE_IN and Input.is_action_just_released("Click") and %ClickTimer.get_time_left() > 0:
		if ScienceSpawn.SCIENCE_READY:
			flashFrog() 
			ScienceSpawn.spawn_science()
		pass
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if Collision.MOUSE_IN:
			if not FrogGlobals.CURRENTLY_DRAGGING and not DRAGGING and event.pressed:
				DRAGGING = true
				FrogGlobals.CURRENTLY_DRAGGING = true
		if DRAGGING and not event.pressed:
			DRAGGING = false
			FrogGlobals.CURRENTLY_DRAGGING = false
			
	if event is InputEventMouseMotion and DRAGGING:
		global_position = event.global_position

func _on_frame_changed():
	#only want to start moving when hopping animation is on frame 3
	if get_frame() == 3 and animation == "hop":
		frogRandomMove()
