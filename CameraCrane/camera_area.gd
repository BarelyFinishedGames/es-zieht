extends Area2D

export(NodePath) var camera_crane

func _on_CameraArea_body_entered(other):
	if other.has_method("is_player"):
		get_node(camera_crane).move_to(position)
