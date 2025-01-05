extends Sprite2D

@export var radius: float
var origin: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	origin = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var angle := randf_range(0, 2*PI)
	var vec := Vector2(cos(angle), sin(angle)) * radius
	position = origin + vec
