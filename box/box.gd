extends RigidBody2D

func is_box():
	return true

func _physics_process(state):
	rotation =  0
	linear_velocity = Vector2(0,0)

func _unhandled_input(event):
	if event.is_action_pressed("push"):
		mode = MODE_RIGID

	if event.is_action_released("push"):
		mode = MODE_STATIC
