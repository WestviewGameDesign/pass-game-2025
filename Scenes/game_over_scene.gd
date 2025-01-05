extends Node
@onready var score := %Score as Label
@onready var retry := %Retry as Button


# Called when the node enters the scene tree for the first time.
func _ready():
	score.text = "You survived for %s against\nthe barrage of asteroids." % GameBus.score_time
	retry.pressed.connect(do_retry)

func do_retry():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
