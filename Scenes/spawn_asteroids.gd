extends PathFollow2D

@export var game: Game
@export var asteroid_target: Node2D
@export var min_asteroid_impulse: float
@export var max_asteroid_impulse: float

@export var min_asteroid_torque: float
@export var max_asteroid_torque: float

@export var asteroid_offset_range: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	progress_ratio = randf()
	game.spawn_asteroid(global_position, Asteroid.AsteroidSize.LARGE, (
		global_position.direction_to(
			asteroid_target.global_position 
			+ Vector2(randf_range(-asteroid_offset_range, asteroid_offset_range), randf_range(-asteroid_offset_range, asteroid_offset_range)))
		* randf_range(min_asteroid_impulse, max_asteroid_impulse)),
		randf_range(min_asteroid_torque, max_asteroid_torque))
