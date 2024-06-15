extends Node2D

var frog_count = 0
@export var frogScene: PackedScene = preload("res://scenes/frog_1.tscn")
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%FrogCount.text = str(frog_count)

func spawn_frog():
	var instance = frogScene.instantiate()
	var randPosX = rng.randi_range(0, get_viewport_rect().end.x - 100)
	var randPosY = rng.randi_range(0, get_viewport_rect().end.y - 100) 
	print(randPosX, randPosY)
	instance.global_position = Vector2(randPosX, randPosY)
	add_child(instance)

func _on_button_pressed():
	spawn_frog() 
	
