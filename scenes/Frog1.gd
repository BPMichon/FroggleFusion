extends Sprite2D
@export_category("STATS")
@export var Health : int = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().frog_count += 1
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
