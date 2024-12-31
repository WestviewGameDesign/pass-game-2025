class_name Asteroid extends RigidBody2D

signal exploded(pos, size, impulse, torque)

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size:= AsteroidSize.LARGE


@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

func _ready():
	# Give the asteroid an initial random push
	#var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	#var random_force = randf_range(100, 300)
	#apply_impulse(random_direction * random_force)
	
	# Give it a random spin
	# var random_spin = randf_range(-1, 1) * 5
	# apply_torque(random_spin)
	
	match size:
		AsteroidSize.LARGE:
			sprite.texture = preload("res://Assets/Asteroids/large asteriod 2.png")
			cshape.shape = preload("res://Resources/asteroid_cshape_large.tres")
			mass = 2
		AsteroidSize.MEDIUM:
			sprite.texture = preload("res://Assets/Asteroids/medium asteriod 1.png")
			cshape.shape = preload("res://Resources/asteroid_cshape_medium.tres")
			mass = 0.7
		AsteroidSize.SMALL:
			sprite.texture = preload("res://Assets/Asteroids/small asteriod 2.png")
			cshape.shape = preload("res://Resources/asteroid_cshape_small.tres")
			mass = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.


func explode():
	exploded.emit(global_position, size, linear_velocity/mass, angular_velocity/inertia)
	queue_free()


func _on_body_entered(body:Node) -> void:
	if body.collision_layer & 0b0000100: # breaks asteroid
		explode()
	
