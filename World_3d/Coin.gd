extends Area

signal coin_collected

func _ready():
    pass

func _on_Coin_body_entered(_body):
    emit_signal("coin_collected")
    $AnimationPlayer.play("Bounce")
    yield(get_tree().create_timer(.6), "timeout")
    set_visible(false)
    queue_free()
