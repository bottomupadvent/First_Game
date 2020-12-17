extends Area

func _ready():
    pass

func _on_Coin_body_entered(body):
    PlayerData.coins += 1
    $AnimationPlayer.play("Bounce")
#    yield(get_tree().create_timer(.7), "timeout")

func _on_VisibilityEnabler_screen_exited():
    queue_free()
