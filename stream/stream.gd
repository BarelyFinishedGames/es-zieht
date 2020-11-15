extends Node2D

onready var ray = $begin/BoxDetector
onready var areaShape = $Area2D/CollisionShape2D
onready var direction = ($end.get_global_position() - $begin.get_global_position()).normalized()

onready var originalEndPosition = $end.position

export(float) var power = 2

export(bool) var enabled = true

var player = null

func is_stream() -> bool:
	return true

func _physics_process(delta):

	if player != null:
		player.force += direction * power

	if ray.is_colliding():
		var other = ray.get_collider() as Node2D

		if other.name.replace("@", "").begins_with("Box"): #apparently sometimes nodes are prefixed with @ by godot at runtime ¯\_(ツ)_/¯

			var pos = ray.get_collision_point()
			$end.global_position = pos

			var length = ($end.position - $begin.position).length()
			var oldExtents = areaShape.shape.get_extents()

			areaShape.shape.set_extents(Vector2(oldExtents.x,length / 2))
			areaShape.position.y -= oldExtents.y - length / 2

			# if the box that currently block the airflow is attached to
			# the player, the exploit prevention collider prevents them from walking through
			if other.attached and enabled:
				$walkthroughPrevention.collision_layer = 1
				$walkthroughPrevention.collision_mask = 1
			else:
				$walkthroughPrevention.collision_layer = 0
				$walkthroughPrevention.collision_mask = 0
			
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
		player = other
	
		var slide = other.get_node("Slide");
	
		if direction.x == 0:
			#slide in x direction

			if abs($end.get_global_position().y - other.position.y) > 30:
				slide.interpolate_property(other, "position",
				other.position, Vector2($end.get_global_position().x, other.position.y), 0.15,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				slide.start()
		else:
			#slide in x direction
			
			if abs($end.get_global_position().x - other.position.x) > 30:
				slide.interpolate_property(other, "position",
				other.position, Vector2(other.position.x, $end.get_global_position().y), 0.15,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				slide.start()

func _on_Area2D_body_exited(other):
	if other.has_method("is_player"):
		player = null
