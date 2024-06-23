extends Area2D

@export var MOUSE_IN = false

func _on_mouse_entered():
	MOUSE_IN = false

func _on_mouse_exited():
	MOUSE_IN = true
