extends KinematicBody

var velocity = Vector3(0, 0, -28)

func _ready():
    pass

func _physics_process(delta):
    velocity = move_and_slide(velocity)
