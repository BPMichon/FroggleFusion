extends Timer
class_name ScienceComponent

@export var frogScienceScene: PackedScene = preload("res://scenes/frog_egg.tscn")

var ScienceTimer = 0
@export var SCIENCE_READY = false
# Creates a New Preloaded Object
func Spawn(position):
	var instance = frogScienceScene.instantiate() 
	instance.position = position
	add_child(instance)
	
func _ready():
	wait_time = ScienceTimer

#When Science Timer amount runs out,
func _on_timeout():
	SCIENCE_READY = true
