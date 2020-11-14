extends RigidBody2D

func is_box():
	return true

func _physics_process(state):
	rotation =  0
	linear_velocity = Vector2(0,0)
