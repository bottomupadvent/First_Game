extends Button

func _on_PlayButton_button_up():
    get_tree().change_scene("res://World_3d/World.tscn")
    PlayerData.reset()
