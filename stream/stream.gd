extends Node2D

onready var ray = $begin/BoxDetector
onready var areaShape = $Area2D/CollisionShape2D
onready var direction = ($end.get_global_position() - $begin.get_global_position()).normalized()

onready var originalEndPosition = $end.position


export(float) var power = 2

export(bool) var enabled = true

func _physics_process(delta):

	if ray.is_colliding():
		var other = ray.get_collider() as Node2D
		if other.has_method("is_box"):

			var pos = ray.get_collision_point()
			$end.global_position = pos

			var length = ($end.position - $begin.position).length()
			var oldExtents = areaShape.shape.get_extents()

			areaShape.shape.set_extents(Vector2(oldExtents.x,length / 2))
			areaShape.position.y -= oldExtents.y - length / 2

		else:
			reset()

	else:
		reset()

func reset():
	$end.position = originalEndPosition

	var length = ($end.position - $begin.position).length()
	var oldExtents = areaShape.shape.get_extents()

	areaShape.shape.set_extents(Vector2(oldExtents.x,length / 2))
	areaShape.position.y += length / 2 - oldExtents.y
	

func _on_Area2D_body_entered(other):
	if enabled and other.has_method("is_player"):
		other.force += direction * power

func _on_Area2D_body_exited(other):
	if other.has_method("is_player"):
		other.force = Vector2()
