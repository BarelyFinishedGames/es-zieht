extends Node2D

onready var direction = ($end.get_global_position() - $begin.get_global_position()).normalized()
export(float) var power = 2

func _on_Area2D_body_entered(other):
	if other.has_method("is_player"):
		other.force += direction * power

func _on_Area2D_body_exited(other):
	if other.has_method("is_player"):
		other.force = Vector2()