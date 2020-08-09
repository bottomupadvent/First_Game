extends RigidBody

signal coin_collected

func _ready():
    angular_velocity = Vector3(0, 5, 0)

func _on_Coin_body_entered(_body):
    set_visible(false)
    emit_signal("coin_collected")
#    queue_free()


func _on_Coin_tree_exiting():
    emit_signal("coin_collected")
