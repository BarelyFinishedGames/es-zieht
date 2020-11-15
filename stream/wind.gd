extends Node2D

var maxDist = 0

func is_wind():
	return true
	
func _process(delta):
	var dist = (get_parent().get_node("begin").position - position).length()
	position.y += 0.75