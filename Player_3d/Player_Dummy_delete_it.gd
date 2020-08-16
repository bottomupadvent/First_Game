extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var constant_speed: Vector3 = Vector3(0, 0, -10)
# Called when the node enters the scene tree for the first time.
func _ready():
    pass


func _physics_process(_delta):
    constant_speed = move_and_slide(constant_speed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
