extends Area

signal coin_collected

func _ready():
    pass

func _on_Coin_body_entered(body):
    emit_signal("coin_collected")
    $AnimationPlayer.play("Bounce")
    yield(get_tree().create_timer(.5), "timeout")
    set_visible(false)
    queue_free()
