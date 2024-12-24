extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

var thrust_force = 1000
var friction = 0.99

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	# Movement input
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	# Normalize diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity += direction * thrust_force * delta
		play_movement_animation(direction)
	else:
		sprite.play("idle")
	
	# Apply friction
	velocity *= friction
	
	move_and_slide()

func play_movement_animation(direction: Vector2):
	if direction.x > 0 and direction.y == 0:
		sprite.play("right")
	elif direction.x < 0 and direction.y == 0:
		sprite.play("left")
	elif direction.y < 0 and direction.x == 0:
		sprite.play("up")
	elif direction.y > 0 and direction.x == 0:
		sprite.play("down")
	elif direction.x > 0 and direction.y < 0:
		sprite.play("up_right")
	elif direction.x > 0 and direction.y > 0:
		sprite.play("down_right")
	elif direction.x < 0 and direction.y < 0:
		sprite.play("up_left")
	elif direction.x < 0 and direction.y > 0:
		sprite.play("down_left")
		

func _process(float):
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("asteroid"):
			print("collided")
			body.explode()
