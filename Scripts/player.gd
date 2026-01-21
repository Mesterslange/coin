extends CharacterBody2D

@export var speed = 200.0

func _physics_process(_delta):
	var dir = Vector2(
		Input.get_action_strength("Move_right") - Input.get_action_strength("Move_left"),
		Input.get_action_strength("Move_down") - Input.get_action_strength("Move_up")
	)

	if dir.length() > 0:
		dir = dir.normalized()
		velocity = dir * speed
		rotation = dir.angle()  # ← Roter spilleren i bevægelsesretningen
	else:
		velocity = Vector2.ZERO

	move_and_slide()
