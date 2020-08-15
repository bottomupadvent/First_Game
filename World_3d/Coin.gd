extends Area

func _ready():
    pass

func _on_Coin_body_entered(_body):
    PlayerData.coins += 1 #PlayerData is a singleton
    $AnimationPlayer.play("Bounce")
    yield(get_tree().create_timer(.6), "timeout")
    set_visible(false)
    queue_free()
