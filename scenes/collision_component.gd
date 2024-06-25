extends Area2D

class_name CollisionComponent
@export var MOUSE_IN = false

func _on_mouse_entered():
	print("In")
	MOUSE_IN = true

func _on_mouse_exited():
	print("Out")
	MOUSE_IN = false
