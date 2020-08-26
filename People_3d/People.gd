extends Area

var stop_pos: Vector3 = Vector3.ZERO
var speed: int
const speedlist = {3: 0.7, 5: 1, 7: 1.3, 11: 1.7}
const state_change = ["stop", "change_dir", "nothing"]
var state_change_value: String
var can_move: bool = false
onready var Player: KinematicBody = get_node("../../PlayerHolder/Player")
onready var PeopleHolder: Spatial = get_node("..")
var direction_to: Vector3
onready var StartTimer: Timer = $StartTimer
onready var AnimPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
    pass

func _physics_process(delta):
    if can_move:
        translation += direction_to * speed * delta
    if get_translation() == stop_pos:
        AnimPlayer.play("Idle")
        can_move = false

func set_start_timer():
#    StartTimer.wait_time = randi() % 2 + 1
#    StartTimer.start()
    AnimPlayer.play("Walk", -1, speedlist[speed])
    can_move = true
    direction_to = translation.direction_to(stop_pos)
    state_change_value = state_change[randi() % state_change.size()]
    if (state_change_value != "nothing"):
        var StateChangeTimer: = Timer.new()
        StateChangeTimer.wait_time = randi() % 5 + 1
        StateChangeTimer.connect("timeout", self, "_on_StateChangeTimer_timeout")
        add_child(StateChangeTimer)
        StateChangeTimer.start()

#func _on_StartTimer_timeout():
#    can_move = true
#    AnimPlayer.play("Walk", -1, speedlist[speed])

func _on_StateChangeTimer_timeout():
    if (state_change_value == "stop"):
        can_move = false
        AnimPlayer.play("Idle")
    else:
        set_physics_process(false)
        stop_pos = Vector3(randi() % 20 + -10, 0,
                            -1*(randi() % 1100 + 50))
        direction_to = translation.direction_to(stop_pos)
        var angle: = atan2(direction_to.x, direction_to.z)
        var person_rot: = get_rotation()
        person_rot.y = angle
        set_rotation(lerp(get_rotation(), person_rot, 0.5))
        set_physics_process(true)

func _on_People_body_entered(body):
    PlayerData.deaths -= 1
    Player.play_blink()

func _on_VisibilityEnabler_screen_exited():
    PeopleHolder.queue_free()
