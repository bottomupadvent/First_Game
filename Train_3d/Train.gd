extends KinematicBody

var constant_speed = Vector3(0, 0, -14)

func _ready():
    pass
    
func _physics_process(delta):
    constant_speed = move_and_slide(constant_speed)



