class_name Game
extends Node2D

#@onready var asteroids = $Asteroids


var asteroid_scene = preload("res://Scenes/asteroid.tscn")

# func _ready():
# 	for asteroid in asteroids.get_children():
# 		asteroid.connect("exploded", _on_asteroid_exploded)
		
func _on_asteroid_exploded(pos, size, impulse, torque):
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				$AsteroidSounds.play()
				spawn_asteroid(pos, Asteroid.AsteroidSize.MEDIUM, impulse, torque)
			Asteroid.AsteroidSize.MEDIUM:
				spawn_asteroid(pos, Asteroid.AsteroidSize.SMALL, impulse, torque)
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

