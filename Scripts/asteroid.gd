extends RigidBody2D

func _ready():
	# Give the asteroid an initial random push
	var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var random_force = randf_range(100, 300)
	apply_impulse(random_direction * random_force)
	
	# Give it a random spin
	var random_spin = randf_range(-1, 1) * 5
	apply_torque(random_spin)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
