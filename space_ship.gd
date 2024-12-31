extends RigidBody2D

@export var max_health = 10000
@export var health = 2500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body:RigidBody2D) -> void:
	if body.collision_layer & 0b00001000: # damages ship
		$AudioStreamPlayer.play()
		print("ship hit")
		health -= absi(floori(body.mass * body.linear_velocity.dot(global_position.direction_to(body.global_position))))
		update_label()
		if health < 0:
			get_tree().quit()


func update_label() -> void:
	$Label.text = "Health %d" % health
