extends HBoxContainer

@onready var FrogImage = %FrogImage
@onready var FrogAmount = %FrogAmount
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#this is called from a frog when it spawns in, where it passes it's name
func UpdateFrog(frogName):
	%FrogAmount.text = str(FrogGlobals.FROG_DATA[frogName]["amount"])
