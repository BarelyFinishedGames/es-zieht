extends Node2D

export(NodePath) var camera_node

onready var camera = get_node(camera_node)

func move_to(destination: Vector2):

	$Tween.interpolate_property(
		camera,
		"position",
		camera.position,
		destination,
		5,
		Tween.TRANS_BACK,
		Tween.EASE_OUT)

	$Tween.start()
