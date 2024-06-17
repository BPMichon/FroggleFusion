extends ScrollContainer

var frogRowScene: PackedScene = preload("res://scenes/frog_row.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var instance
	#populate menu with frog icons and their amounts
	for frog in FrogGlobals.FROG_DATA:
		instance = frogRowScene.instantiate()
		print(FrogGlobals.FROG_DATA[frog]["imagePath"])
		#the group is called the frog's name, which is sent a signal every time that frog spwans in
		instance.add_to_group(frog)
		%VBoxContainer.add_child(instance)
		#if locked
			#image is a question mark
			#amount is 0
		#else
		instance.FrogImage.texture = ResourceLoader.load(FrogGlobals.FROG_DATA[frog]["imagePath"])
		instance.FrogAmount.text = str(FrogGlobals.FROG_DATA[frog]["amount"])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
