extends Area2D

func _on_CameraArea_body_entered(other):
	if other.has_method("is_player"):
		get_parent().get_node("CameraCrane").move_to(position)
