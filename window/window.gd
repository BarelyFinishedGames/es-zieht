extends Node2D

export(bool) var open = true


export(int) var angle_open = -90

var busy = false
var playerPresent = false

onready var stream_end_collider = $Stream/end/StaticBody2D/CollisionShape2D

func _ready():
	$Stream.enabled = open

	$origin.rotation_degrees = angle_open if open else 0
	
func _on_trigger_body_entered(other):
	if other.has_method("is_player"):
		playerPresent = true
		

func _process(delta):
	if not busy and playerPresent && Input.is_action_pressed("push"):
		busy = true
		open = !open
		$Stream.enabled = open
		stream_end_collider.disabled = !open

		var player = get_parent().get_node("Player")
		if open:
			$Stream._on_Area2D_body_entered(player)

			rotate(angle_open)

		else:
			player.force = Vector2(0,0)

			rotate(0)
		
		if open:
			$WindowOpen.play()
		else: 
			$WindowClosed.play()

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
