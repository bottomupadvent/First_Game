extends KinematicBody

const tilesize: int = 5
const minimum_drag: int = 15
signal swipe
var swipe_start: float
var swipe_end: float
var velocity: Vector3 = Vector3.ZERO
var constant_speed: Vector3 = Vector3(0, 0, -29)
var first_button_press: bool = true
var row: int = 3
onready var sprint_button = get_node("../../HUD/Sprint")
onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
onready var SprintTimeout: Timer = $SprintTimeout
onready var Tweening: Tween = $Tween

func _ready():
    sprint_button.connect("button_down", self, "_on_Sprint_button_down")
    sprint_button.connect("button_up", self, "_on_Sprint_button_up")

func _physics_process(_delta):
    if !AnimPlayer.is_playing():
        AnimPlayer.play("Running")
    constant_speed = move_and_slide(constant_speed)
    
func _input(event):
    if event is InputEventScreenTouch and event.is_pressed():
        swipe_start = event.position.x

    elif event is InputEventScreenTouch and !event.is_pressed():
        swipe_end = event.position.x
        if (abs(swipe_end - swipe_start) > minimum_drag):
            if (swipe_end - swipe_start > 0) and row != 1:
                emit_signal("swipe", "right")
                row -= 1
            elif (swipe_end - swipe_start < 0) and row != 4:
                emit_signal("swipe", "left")
                row += 1

func _on_Player_swipe(direction):
    if direction == "right":
        var move_to_right = get_translation() + Vector3(7.0, 0, -3)
        Tweening.interpolate_property(self, "translation", get_translation(),
                                    move_to_right, 0.1, Tween.TRANS_LINEAR, 
                                    Tween.EASE_IN_OUT)
        Tweening.start()
    else:
        var move_to_left = get_translation() + Vector3(-7.0, 0, -3)
        Tweening.interpolate_property(self, "translation", get_translation(),
                                    move_to_left, 0.1, Tween.TRANS_LINEAR, 
                                    Tween.EASE_IN_OUT)
        Tweening.start()

func _on_Sprint_button_down():
    if (first_button_press == true):
        first_button_press = false
        SprintTimeout.start(SprintTimeout.wait_time)
    else:
        SprintTimeout.set_paused(false)
    constant_speed += Vector3(0, 0, -7)
    AnimPlayer.playback_speed = 1.4

func _on_Sprint_button_up():
    SprintTimeout.set_paused(true)
    constant_speed += Vector3(0, 0, 7)
    AnimPlayer.playback_speed = 1

func _on_SprintTimeout_timeout():
    sprint_button.set_disabled(true)
    constant_speed = Vector3(0, 0, -29)
    AnimPlayer.playback_speed = 1

func play_blink():
    AnimPlayer.play("Blink")
    constant_speed += Vector3(0, 0, 20)
    yield(get_tree().create_timer(.5), "timeout")
    constant_speed += Vector3(0, 0, -20)
