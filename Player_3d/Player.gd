extends KinematicBody

var tilesize = 5
signal swipe
var swipe_start = null
var minimum_drag = 20
var velocity = Vector3(0, 0, 0)
var constant_speed = Vector3(0, 0, -29)
var first_button_press = true
onready var sprint_button = get_node("../HUD/Sprint")
# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func _physics_process(delta):
    if !$AnimationPlayer.is_playing():
        $AnimationPlayer.play("Running")
#    if !$Tween.is_active():
#       constant_speed = Vector3(0, 0, -15)
        
    constant_speed = move_and_slide(constant_speed)
    
func _input(event):
    if event.is_action_pressed("click"):
        swipe_start = event.position
    if event.is_action_released("click"):
        _calculate_swipe(event.position)

func _calculate_swipe(swipe_end):
    if swipe_start == null: 
        return
    var swipe = swipe_end - swipe_start
    if abs(swipe.x) > minimum_drag:
        if swipe.x > 0:
            emit_signal("swipe", "right")
        else:
            emit_signal("swipe", "left")

func _on_Player_swipe(direction):
    if direction == "right":
        var move_to_right = get_translation() + Vector3(7.0, 0, -5)
#        $Player_anim/AnimationPlayer.play("Jump_right", -1, 1.4)
        $Tween.interpolate_property(self, "translation", get_translation(),
                                    move_to_right, 0.1, Tween.TRANS_LINEAR, 
                                    Tween.EASE_IN_OUT)
        $Tween.start()
        # $Idle/AnimationPlayer.animation_set_next("Jump_right", "Running")
    else:
        var move_to_left = get_translation() + Vector3(-7.0, 0, -5)
#        $Player_anim/AnimationPlayer.play("Jump_left", -1, 1.4)
        $Tween.interpolate_property(self, "translation", get_translation(),
                                    move_to_left, 0.1, Tween.TRANS_LINEAR, 
                                    Tween.EASE_IN_OUT)
        $Tween.start()

       #  $Idle/AnimationPlayer.animation_set_next("Jump_left", "Running")


func _on_Area_body_entered(body):
    $AnimationPlayer.play("Blink")
    
#func _on_SprintTimer_timeout():
#    $Sprint.set_disabled(true)
#    constant_speed = Vector3(0, 0, -25)

func _on_Sprint_button_down():
    if (first_button_press == true):
        first_button_press = false
        $SprintTimeout.start($SprintTimeout.wait_time)
    else:
        $SprintTimeout.set_paused(false)
        
    constant_speed += Vector3(0, 0, -7)

func _on_Sprint_button_up():
    $SprintTimeout.set_paused(true)
    constant_speed += Vector3(0, 0, 7)

func _on_SprintTimeout_timeout():
    sprint_button.set_disabled(true)
    constant_speed = Vector3(0, 0, -29)
    
