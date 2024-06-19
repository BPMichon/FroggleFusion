extends Sprite2D
var NEW_POSITION

func Suicide():
	var tween = get_tree().create_tween()
	#tween.set_speed_scale()
	tween.tween_property(self,"global_position",CalculateBackwardsPosition( global_position, NEW_POSITION) , 0.2).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "global_position", NEW_POSITION, 1 ).set_trans(Tween.TRANS_CIRC)
	
	await tween.finished
	queue_free()
	FrogGlobals.SCIENCE_COUNT += 1
	var Destination = get_tree().get_nodes_in_group("MainNode")
	Destination[0].onScienceHit()
	
## Egg travels Backwards before going to final destination

func CalculateBackwardsPosition(Initial, Final):
	var DifferenceX = Final.x - Initial.x 
	var DifferenceY = Final.y - Initial.y
	
	var NewFinalx = Initial.x - (DifferenceX/8)
	var NewFinaly = Initial.y -(DifferenceY/12)
	return Vector2(NewFinalx,NewFinaly)
# Called when the node enters the scene tree for the first time.
func _ready():
	#get the science counter coords, which the eggs are going to fire at
	var Destination = get_tree().get_nodes_in_group("ScienceDestination")
	var pos = Destination[0].get_global_position()
	var size = Destination[0].get_size()
	#position gets the top left coord of the science counter. This gets the centre of the counter
	NEW_POSITION = Vector2(pos.x + 0.5*(size.x), pos.y + 0.5*(size.y) )
	Suicide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
