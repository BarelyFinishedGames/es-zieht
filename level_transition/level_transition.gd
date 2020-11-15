extends Node2D

# place this note somwewhere and assign 
# a destination scene in the inspector

export(PackedScene) var scene

func _on_Area2D_body_entered(other):
	if other.has_method("is_player"):
		get_tree().change_scene_to(scene)
