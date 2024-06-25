extends Resource
class_name FrogData
@export var health: int
@export var unlocked: bool
@export var spriteFrame : SpriteFrames
@export var imagePath : String

func _init(p_health = 0,p_unlocked = false,p_spriteFrame = null,p_imagePath = ""):
	health = p_health
	unlocked = p_unlocked
	spriteFrame = p_spriteFrame
	imagePath = p_imagePath
