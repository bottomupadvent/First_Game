extends Area

signal coin_collected

func _ready():
    pass
    
func _physics_process(delta):
    rotation_degrees.y += 150 * delta

func _on_Coin_body_entered(body):
    emit_signal("coin_collected")
    set_visible(false)
    queue_free()
