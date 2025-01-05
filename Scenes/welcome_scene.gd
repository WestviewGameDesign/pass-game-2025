extends Node
@onready var retry := %Retry as Button


# Called when the node enters the scene tree for the first time.
func _ready():
	retry.pressed.connect(do_retry)

func do_retry():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
