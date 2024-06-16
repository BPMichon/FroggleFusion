extends Node2D

var frog_count = 0

@export var frogScene: PackedScene = preload("res://scenes/frog_1.tscn")
var rng = RandomNumberGenerator.new()


#Global Variables
var FROG_SCIENCE


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	%FrogCount.text = str(frog_count)
	%ScienceCount.text = str(FrogGlobals.SCIENCE_COUNT)
	
func spawn_frog():
	var instance = frogScene.instantiate()
	var randPosX = rng.randi_range(0, get_viewport_rect().end.x - 100)
	var randPosY = rng.randi_range(0, get_viewport_rect().end.y - 100) 
	instance.global_position = Vector2(randPosX, randPosY)
	add_child(instance)

func _on_button_pressed():
	spawn_frog() 
	
#called when a frog tadpole hits the science counter
func onScienceHit():
	#makes it small then big
	var tween = get_tree().create_tween()
	tween.tween_property(%ScienceCount,"theme_override_font_sizes/font_size", 90, 0.1)
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(%ScienceCount,"theme_override_font_sizes/font_size", 100, 0.1)
	await tween.finished
