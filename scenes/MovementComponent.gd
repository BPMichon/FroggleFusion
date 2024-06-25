extends Node2D

class_name MovementComponent

## We Assume that our parent is always a AnimatedSprite2D
@export var IDLE_ANIM   : String
@export var MOVING_ANIM : String

@export var NEW_POSITION : Vector2

func SetupMovement(IDLE,MOVING,position):
	IDLE_ANIM = IDLE
	MOVING_ANIM = MOVING
	
	NEW_POSITION = await calculateNextRandCoord(position)

func calculateNextRandCoord(position):
	#print("FindingNewPosition")
	var isFrogOnScreen = false
	var NewPosition
	var xOffset
	var yOffset
	var largestX = get_viewport_rect().end.x - 100
	var largestY = get_viewport_rect().end.y - 100 
	#the bounce animation takes it off screen, we need to minus the max bounce height from this
	
	#idle for a random time
	randomize()
	await get_tree().create_timer(randf_range(2,4)).timeout
	
	#calculate the new movement position
	#and check that the new frog coords are on the screen
	while isFrogOnScreen == false:
		xOffset = randi_range(-100, 100)
		yOffset = randi_range(-100, 100)
		NewPosition = Vector2(position.x + xOffset, position.y + yOffset)
		if NewPosition.x < largestX and NewPosition.x > 0 and NewPosition.y < largestY and NewPosition.y > 0:
			isFrogOnScreen = true
	
	#flip frog if new movement direction
	if get_parent().flip_h == true:
		if NewPosition.x > position.x:
			get_parent().flip_h = false
	else:
		if NewPosition.x < position.x:
			get_parent().flip_h = true
			
	#begin hopping
	get_parent().play(MOVING_ANIM)
	return NewPosition

func frogRandomMove(MoveableObject):
	var tween = get_tree().create_tween()
	tween.tween_property(MoveableObject, "position", NEW_POSITION, (0.6))

	await tween.finished
	
	get_parent().play(IDLE_ANIM)
	NEW_POSITION = await calculateNextRandCoord(NEW_POSITION)
	


