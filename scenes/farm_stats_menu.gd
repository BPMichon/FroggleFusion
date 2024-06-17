extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_close_farm_stats_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property(self ,"global_position", Vector2(1632, 1127), 0.6).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	#self.visible = false
	pass # Replace with function body.
	
