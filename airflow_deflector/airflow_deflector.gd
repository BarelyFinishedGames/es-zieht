extends RigidBody2D

var original_rotation;

var is_deflecting = false

func is_airflow_deflector():
	return true

func _ready():
	original_rotation = rotation

func _physics_process(state):
	rotation = original_rotation
	linear_velocity = Vector2(0,0)
