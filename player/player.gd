extends KinematicBody2D

var direction = Vector2(0,0)

export(float) var velocity = 3.0

var force = Vector2()

var can_move = true;

func is_player() -> bool:
	return true

func _physics_process(delta):

	direction = Vector2()

	if force.length() == 0:
		if !can_move:
			can_move = true;
	else:
		if can_move:
			can_move = false;

	if can_move:
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
		turn(direction)
	else:
		$Sprite.stop()
	
	direction += force
	
	var allow_turn = true
	
	for area in $CollisionShape2D/Area2D.get_overlapping_areas():
		if area.get_parent() != null and area.get_parent().has_method("is_stream"):
			if $CollisionShape2D/Area2D.overlaps_body(area.get_parent().get_node("end/StaticBody2D")):
				allow_turn = false
	
	if direction.length() != 0 and allow_turn:
		turn(direction)
	
	move_and_collide(direction.normalized() * velocity * delta)
	
	force = Vector2()
	
func get_degrees(vector) -> float:
	return atan2(vector.y, vector.x)*180/PI

func turn(vecor):
	$Sprite.rotation_degrees = get_degrees(direction)
	$CollisionShape2D.rotation_degrees = get_degrees(direction)

func _on_Slide_tween_started(object, key):
	can_move = false;

func _on_Slide_tween_all_completed():
	can_move = true;
