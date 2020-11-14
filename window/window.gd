extends Node2D

export(bool) var open = true

var color_open = Color(0,255,0)
var color_closed = Color(255,0,0)

export(int) var angle_open = -90

var busy = false
var playerPresent = false

func _ready():
	$Stream.enabled = open
	$origin/trigger/Polygon2D.color = color_open if open else color_closed

	$origin.rotation_degrees = angle_open
	
func _on_trigger_body_entered(other):
	if other.has_method("is_player"):
		playerPresent = true
		

func _process(delta):
	if not busy and playerPresent && Input.is_action_pressed("push"):
		busy = true
		open = !open
		$Stream.enabled = open

		var player = get_parent().get_node("Player")
		if open:
			$Stream._on_Area2D_body_entered(player)
			$origin/trigger/Polygon2D.color = color_open

			rotate(angle_open)

		else:
			player.force = Vector2(0,0)
			$origin/trigger/Polygon2D.color = color_closed

			rotate(0)

func rotate(new):
	$Tween.interpolate_property($origin, "rotation_degrees",
	$origin.rotation_degrees, new, 0.75,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	busy = false


func _on_trigger_body_exited(other):
	if other.has_method("is_player"):
		playerPresent = false
