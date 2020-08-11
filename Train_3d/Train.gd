extends RigidBody

var velocity: Vector3 = Vector3(0, 0, -28)

func _ready():
    linear_velocity = velocity

