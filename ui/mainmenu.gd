extends TextureRect

export(PackedScene) var firstLevel

func _on_btExit_button_down():
	get_tree().quit()

func _on_btStart_button_down():
	get_tree().change_scene("./tutorial.tscn")
