extends Node2D

const height = 1280*2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	position += Vector2.DOWN * (delta * 64)


func _on_visibility_screen_exited():
	position += Vector2.UP * (height * 2)
