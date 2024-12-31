extends Node2D

@export var bullet_scene: PackedScene
@export var shoot_impulse := 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = 0
	rotation = get_local_mouse_position().angle()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var bullet: RigidBody2D = bullet_scene.instantiate()
		$ShootPoint.add_child(bullet)
		bullet.reparent(get_parent().get_parent()) # bad code
		var impulse = global_position.direction_to(bullet.global_position) * shoot_impulse
		bullet.apply_central_impulse(impulse)
		get_parent().apply_central_impulse(-global_position.direction_to(bullet.global_position) * shoot_impulse)
		$AudioStreamPlayer.play()
