extends KinematicBody2D

var direction = Vector2(0,0)

export(float) var velocity = 3.0

var force = Vector2()

func is_player() -> bool:
	return true

func _physics_process(delta):

	direction = Vector2()

	if Input.is_action_pressed("move_up"):
		direction += Vector2.UP

	if Input.is_action_pressed("move_left"):
		direction += Vector2.LEFT

	if Input.is_action_pressed("move_down"):
		direction += Vector2.DOWN

	if Input.is_action_pressed("move_right"):
		direction += Vector2.RIGHT

	if direction.length() != 0:
		$Sprite.play("run")
		$Sprite.rotation_degrees = get_degrees(direction)
		$CollisionShape2D.rotation_degrees = get_degrees(direction)
	else:
		$Sprite.stop()
	
	direction += force
	move_and_collide(direction.normalized() * velocity * delta)
	
func get_degrees(vector) -> float:
	return atan2(vector.y, vector.x)*180/PI
