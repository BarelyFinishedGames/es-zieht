extends StaticBody2D

var player_present = false
var attached = false

var player

# after detaching from the player, there are three consecutive player entering events
# to be expected before the next real one can occur
var number_of_fake_enterings = 0

func is_box():
	return true

const PLAYER_COLLISION_LAYER = 1
const BOX_DETECTION_LAYER = 2

var playerOffset = Vector2()

func _process(_delta):
	if player_present and Input.is_action_pressed("push") and attached == false and number_of_fake_enterings == 0:

		player = get_parent().get_node("Player")

		playerOffset = position - player.position

		collision_layer = BOX_DETECTION_LAYER;
		collision_mask = BOX_DETECTION_LAYER;

		get_parent().remove_child(self)

		player.call_deferred("add_child", self)
		call_deferred("set_position", playerOffset)

		attached = true
		number_of_fake_enterings = 3

	if not Input.is_action_pressed("push") and attached:

		var pos = global_position
		player.remove_child(self)
		player.get_parent().add_child(self)
		set_position(pos)

		attached = false

		collision_layer = BOX_DETECTION_LAYER | PLAYER_COLLISION_LAYER
		collision_mask = BOX_DETECTION_LAYER | PLAYER_COLLISION_LAYER


func _on_Area2D_body_entered(other):
	if other.has_method("is_player"):

		if number_of_fake_enterings == 0:
			# this is a legit enter

			player_present = true
		else:
			number_of_fake_enterings -= 1

		

func _on_Area2D_body_exited(other):
	if other.has_method("is_player"):
		player_present = false
