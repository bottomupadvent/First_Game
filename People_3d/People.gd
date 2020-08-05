extends KinematicBody

var total_people = 30
var stop_pos = Vector3()
var speed = 5
var can_move = false
onready var Player = get_node("../Player")
var direction_to

func _ready():
    pass

func _physics_process(delta):
    if can_move:
        move_and_slide(direction_to * speed)
    if get_translation().z - 30 > Player.get_translation().z:
        queue_free()
    if get_translation() == stop_pos:
        $People_anim/AnimationPlayer.play("Idle")
    
func set_start_timer():
    $StartTimer.wait_time = randi() % 10 + 1
    $StartTimer.start()
    direction_to = translation.direction_to(stop_pos)

func _on_StartTimer_timeout():
    can_move = true
    $People_anim/AnimationPlayer.play("Walk")
