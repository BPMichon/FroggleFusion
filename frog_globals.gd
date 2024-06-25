extends Node

const FrogData = preload("frog_data.gd")

var SCIENCE_COUNT = 0
#I want to make an enumerated type of the different frogs to make it easier for us
enum FROG_TYPES {BlueGreenFrog, OtherFrog}
var CURRENTLY_DRAGGING = false
var FROG_DATA = {
	FROG_TYPES.BlueGreenFrog: {
					"amount": 0,
					"imagePath": "res://art/greenBlueFrog.png",
					"unlocked": true}, 
	FROG_TYPES.OtherFrog: {
					"amount": 30,
					"imagePath": "res://Frog_1.png",
					"unlocked": false}
}


var NEW_FROG_DATA = {
	"BlueGreenFrog" : FrogData.new(10) 
	}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
