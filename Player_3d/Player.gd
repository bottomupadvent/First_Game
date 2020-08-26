extends KinematicBody

var which_dabba: String
var move_into_dabba: bool = false
const tilesize: int = 5
const minimum_drag: int = 15
signal swipe
var swipe_start: float
var swipe_end: float
var velocity: Vector3 = Vector3.ZERO
var constant_speed: Vector3 = Vector3(0, 0, -40)
var first_button_press: bool = false
var row: int = 3
var input_index
onready var sprint_button = get_node("../../HUD/Sprint")
onready var Main = get_node("../..")
#onready var Train: RigidBody = get_node("../../TrainHolder/Train")
onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
onready var SprintTimeout: Timer = $SprintTimeout
onready var SpawnPeople: Timer = $SpawnPeople
onready var Tweening: Tween = $Tween

func _ready():
#    Train.connect("entered_dabba_area", self, "_on_Dabba_Area_entered")
#    Train.connect("exited_dabba_area", self, "_on_Dabba_Area_exited")
    sprint_button.connect("button_down", self, "_on_Sprint_button_down")
    sprint_button.connect("button_up", self, "_on_Sprint_button_up")
    pass

func _physics_process(delta):

    constant_speed = move_and_slide(constant_speed)

func _input(event):
    if event is InputEventScreenTouch and event.is_pressed():
        input_index = event.get_index()
        swipe_start = event.position.x

    elif event is InputEventScreenDrag and event.index == input_index:
        var event_position = event.get_position().x
        if abs(event_position - swipe_start) > minimum_drag and first_button_press == false:
            first_button_press = true
            if (event_position - swipe_start > 0 and row != 1 or move_into_dabba == true):
                emit_signal("swipe", "right")
#                if (move_into_dabba == true):
#                    get_tree().change_scene("res://Screens/EndScreenPassed.tscn")
#                    PlayerData.reset()
                row -= 1
            elif (event_position - swipe_start < 0 and row != 4):
                emit_signal("swipe", "left")
                row += 1

    elif event is InputEventScreenTouch and !event.is_pressed() and event.index == input_index:
        first_button_press = false

func _on_Player_swipe(direction):
    if direction == "right":
        var move_to_right = get_translation() + Vector3(7.0, 0, -5)
        Tweening.interpolate_property(self, "translation", get_translation(),
                                    move_to_right, 0.2, Tween.TRANS_LINEAR,
                                    Tween.EASE_IN_OUT)
        Tweening.start()
    else:
        var move_to_left = get_translation() + Vector3(-7.0, 0, -5)
        Tweening.interpolate_property(self, "translation", get_translation(),
                                    move_to_left, 0.2, Tween.TRANS_LINEAR,
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
    yield(get_tree().create_timer(.8), "timeout")
    constant_speed += Vector3(0, 0, -20)
    AnimPlayer.play("Running")

func _on_SpawnPeople_timeout():
    Main.spawn_people()

#func _on_Dabba_Area_entered(dabba):
#    which_dabba = dabba
#    move_into_dabba = true
#
#func _on_Dabba_Area_exited():
#    move_into_dabba = false


