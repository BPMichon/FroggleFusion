extends AnimatedSprite2D

class_name FrogClass

#Define All Children Components
@export var newFrogType : FrogData

@onready var Collision : CollisionComponent = %Collision
@onready var ScienceSpawn : ScienceComponent = %ScienceSpawn 
@onready var Movement :MovementComponent = $MovementComponent

#Variables Specific to Frog
@export var frogType: FrogGlobals.FROG_TYPES
@export var DRAGGING = false
@export var NEW_POSITION : Vector2

func WriteName():
	print("Frog Class")
	
# Adds a number to the Global Data
func updateFrogCount(Amount):
	
	# The way we handle updating User Interface Could be Changed
	# Instead of changing one variable call a global method
	# Which Updates the whole User Interface Screen
	
	FrogGlobals.FROG_DATA[frogType]["amount"] += 1
	var Destination = get_tree().get_nodes_in_group(str(frogType))
	Destination[0].UpdateFrog(frogType)
	pass


# Frog turns white before returning to normal Colour
func flashFrog():
	## Change Function to set variable Timer?
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self, "modulate:v", 1, 0.25).from(15)
	pass


func _ready():
	#Starts Science SpawnTimer
	ScienceSpawn.start()
	Movement.SetupMovement("Idle","hop",position)
	#NEW_POSITION = Movement.calculateNextRandCoord()
	pass


func _process(_delta):
	
	if Collision.MOUSE_IN and Input.is_action_just_pressed("Click"):
		print("ClickedFrog")
		%ClickTimer.start(0.2)
	if Collision.MOUSE_IN and Input.is_action_just_released("Click") and %ClickTimer.get_time_left() > 0:
		if ScienceSpawn.SCIENCE_READY:
			flashFrog() 
			ScienceSpawn.Spawn(position)
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

# Frog Movement Occurs on Sprite Animation Changes
func _on_frame_changed():
	#only want to start moving when hopping animation is on frame 3
	if get_frame() == 3 and animation == "hop":
		Movement.frogRandomMove(self)
