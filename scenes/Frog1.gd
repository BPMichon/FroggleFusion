extends Sprite2D
@export_category("STATS")
@export var Health : int = 10#
#Scenes Preloads 
@export var frogScienceScene: PackedScene = preload("res://scenes/frog_egg.tscn")

#Global variables
var NEW_POSITION
var SCIENCE_COOLDOWN = 0.01
var SCIENCE_READY : bool = false
var MouseIn = false
@export var frogType: FrogGlobals.FROG_TYPES

# Called when the node enters the scene tree for the first time.
func _ready():
	#if get_parent().has_meta("frog_count"):
		#get_parent().frog_count += 1
	
	FrogGlobals.FROG_DATA[frogType]["amount"] += 1
	var Destination = get_tree().get_nodes_in_group(str(frogType))
	Destination[0].UpdateFrog(frogType)
	calculateNextRandCoord()
	startScienceTimer()

func spawn_science():
	var instance = frogScienceScene.instantiate() 
	instance.position = %AnimatedSprite2D.position
	add_child(instance)
	
func startScienceTimer():
	%ScienceTimer.wait_time = 60*(SCIENCE_COOLDOWN)
	%ScienceTimer.start()
	
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

var DRAGGING = false
var CLICK_RADIUS = 32
var clickTimer
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if MouseIn:
			if not DRAGGING and event.pressed:
				DRAGGING = true
		if DRAGGING and not event.pressed:
			DRAGGING = false
	
	
	if event is InputEventMouseMotion and DRAGGING:
		%AnimatedSprite2D.global_position = event.global_position
	elif event is InputEventMouseButton and event.factor > 1 and DRAGGING:
		if SCIENCE_READY:
			var tween1 = get_tree().create_tween()
			tween1.tween_property(%AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
	
			## Shit Tadpole 
			spawn_science()
	
func _process(_delta):
	#if left click and moving then dragging
	#if MouseIn and Input.is_action_just_pressed("Click"): #and isnt dragging
		#if SCIENCE_READY:
			#var tween1 = get_tree().create_tween()
			#tween1.tween_property(%AnimatedSprite2D, "modulate:v", 1, 0.25).from(15)
			#
			### Shit Tadpole 
			#spawn_science()
	pass
	#if left click and dragging then move sprite
	#if release and dragging then release sprite and set not dragging


func _on_animated_sprite_2d_frame_changed():
	#only want to start moving when hopping animation is on frame 3
	if %AnimatedSprite2D.get_frame() == 3 and %AnimatedSprite2D.animation == "hop":
		frogRandomMove()


func _on_area_2d_mouse_entered():
	MouseIn = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	MouseIn = false
	pass # Replace with function body.

#Make Frog Ready to Shit
func _on_science_timer_timeout():
	SCIENCE_READY = true
