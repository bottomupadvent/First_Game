extends CanvasLayer

signal start_game

func _ready():
    pass

func show_message():
    $MessageTimer.start()
    
func show_game_over():
    # Wait until the MessageTimer has counted down.
    yield($MessageTimer, "timeout")
    $StartButton.show()

func _on_StartButton_pressed():
    $StartButton.hide()
    emit_signal("start_game")
