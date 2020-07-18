extends Node2D

var speed = 100
var constant_speed = Vector2(speed, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
    constant_speed = constant_speed.rotated(deg2rad(-114))

func _physics_process(delta):
    position += constant_speed * delta
