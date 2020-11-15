extends Node2D

func is_door() -> bool:
	return true

export(int) var angle_open = 90

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.get_parent() != null and area.get_parent().has_method("is_stream"):
		$Tween.interpolate_property($origin, "rotation_degrees",
		$origin.rotation_degrees, angle_open, 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
