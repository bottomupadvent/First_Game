extends KinematicBody

var total_people = 10
var stop_pos = Vector3()

func _ready():
    pass

func _physics_process(delta):
    if get_translation() == stop_pos:
        $People_anim/AnimationPlayer.play("Idle")

func set_start_timer():
    $StartTimer.wait_time = randi() % 10 + 1
    $StartTimer.start()
    
func start_tweening():
    $People_anim/AnimationPlayer.play("Walk")
    $Tween.interpolate_property(self, "translation",
                                get_translation(), stop_pos, randi() % 10 + 5,
                                Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    $Tween.start()

func _on_StartTimer_timeout():
    start_tweening()
