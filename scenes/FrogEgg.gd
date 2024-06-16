extends Sprite2D
var NEW_POSITION

func Suicide():
	var tween = get_tree().create_tween()
	#tween.set_speed_scale()
	tween.tween_property(self,"global_position",CalculatePosition( global_position, NEW_POSITION) , 0.2).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "global_position", NEW_POSITION, 1 ).set_trans(Tween.TRANS_CIRC)
	
	await tween.finished
	queue_free()
	FrogGlobals.SCIENCE_COUNT += 1
	var Destination = get_tree().get_nodes_in_group("MainNode")
	Destination[0].onScienceHit()
	

func CalculatePosition(Initial, Final):
	var DifferenceX = Final.x - Initial.x 
	var DifferenceY = Final.y - Initial.y
	
	var NewFinalx = Initial.x - (DifferenceX/8)
	var NewFinaly = Initial.y -(DifferenceY/12)
	return Vector2(NewFinalx,NewFinaly)
# Called when the node enters the scene tree for the first time.
func _ready():
	var Destination = get_tree().get_nodes_in_group("ScienceDestination")
	NEW_POSITION = Destination[0].get_position()
	Suicide()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if position == NEW_POSITION:
	#	queue_free()
	pass
