extends Area

var stop_pos: Vector3 = Vector3.ZERO
var speed: int
var speedlist = {3: 0.7, 5: 1, 7: 1.3, 11: 1.7}
var can_move: bool = false
onready var Player = get_node("../Player")
var direction_to
onready var StartTimer = $StartTimer
onready var AnimPlayer = $People_anim/AnimationPlayer
onready var PersonSkeleton = $People_anim/Skeleton
var noOfQueueFree: int = 1

func _ready():
    pass

func _physics_process(delta):
    if can_move:
        translation += direction_to * speed * delta
#    if get_translation().z - 35 > Player.get_translation().z:
#        queue_free()
    if get_translation() == stop_pos:
        AnimPlayer.play("Idle")
    
func set_start_timer():
    StartTimer.wait_time = randi() % 10 + 1
    StartTimer.start()
    direction_to = translation.direction_to(stop_pos)

func _on_StartTimer_timeout():
    can_move = true
    AnimPlayer.play("Walk", -1, speedlist[speed])

func _on_People_body_entered(_body):
    Player.play_blink()

func _on_VisibilityEnabler_screen_exited():
#    noOfQueueFree += 1
    queue_free()
