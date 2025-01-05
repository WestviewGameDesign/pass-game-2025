class_name Game
extends Node2D

#@onready var asteroids = $Asteroids

var start_time: float
var end_time: float = 0.0
var asteroid_scene = preload("res://Scenes/asteroid.tscn")
@onready var timer = %Timer
@onready var game_over_seq = %GameOverSeq

func _ready():
	start_time = Time.get_ticks_usec() / 1e6
	GameBus.game_over.connect(_game_over)

func _game_over():
	end_time = Time.get_ticks_usec() / 1e6
	var survived = end_time - start_time
	GameBus.score_time = dur_to_str(survived)
	game_over_seq.play("game_over")

func get_out():
	get_tree().change_scene_to_file("res://Scenes/game_over_scene.tscn")

func dur_to_str(dur: float) -> String:
	var seconds := dur
	var minutes := floori(seconds / 60)
	var hours := floori(minutes / 60)
	seconds -= minutes * 60
	minutes -= hours * 60
	if hours > 0:
		return "%02d:%02d:%05.2f" % [hours, minutes, seconds]
	if minutes > 0:
		return "%02d:%05.2f" % [minutes, seconds]
	return "%.2fs" % [seconds]

func _process(delta: float) -> void:
	var duration := Time.get_ticks_usec() / 1e6 - start_time
	if end_time != 0:
		duration = end_time - start_time
	var durastr := dur_to_str(duration)
	timer.text = "TIME: %s" % durastr

# func _ready():
# 	for asteroid in asteroids.get_children():
# 		asteroid.connect("exploded", _on_asteroid_exploded)
		
func _on_asteroid_exploded(pos, size, impulse, torque):
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				$AsteroidSounds.play()
				var task = func(): spawn_asteroid(pos, Asteroid.AsteroidSize.MEDIUM, impulse, torque)
				task.call_deferred()
			Asteroid.AsteroidSize.MEDIUM:
				var task = func(): spawn_asteroid(pos, Asteroid.AsteroidSize.SMALL, impulse, torque)
				task.call_deferred()
			Asteroid.AsteroidSize.SMALL:
				pass
	
func spawn_asteroid(pos, size, impulse, torque):
	var a: RigidBody2D = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	self.add_child(a)
	a.apply_central_impulse(impulse)
	a.apply_torque_impulse(torque)
