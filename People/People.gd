extends KinematicBody2D

var tilesize = 83
# Next two lines 100 is a any random number.
var path_right = 100
var path_left = 100
var path = int()
var direction_list = [1, 2, 3, 4]
var direction = int()
export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var speed = Vector2(0, 0)
export var total_people = 20
export var velocity = Vector2()
var move = bool()
var linear_velocity = Vector2()
var end_path = int()

# var angles_list = [8, 66, 172, 246]
var angles_list = [8]

func _ready():
    randomize()

func set_parameters():
    # Direction and speed
    
    speed.x = randi() % 200 + 50
    if (direction == 1):
        linear_velocity = speed.rotated(deg2rad(-114))
        $StopTimer.wait_time = rand_range(20.0, 30.0)
        $StopTimer.autostart = true
    if (direction == 3):
        linear_velocity = speed.rotated(deg2rad(66))
        $StopTimer.wait_time = rand_range(20.0, 30.0)
        $StopTimer.autostart = true
    # rotation_degrees = direction
    if (direction == 2 or direction == 4):     
        $StartTimer.wait_time = rand_range(0.1, 3.0)
        $StartTimer.autostart = true

func _physics_process(delta):
    if (direction == 1 or direction == 3):
        move_and_slide(linear_velocity)

func _on_StartTimer_timeout():
    print("path_left ", path_left)
    print("path_right ", path_right)
    var end_position = Vector2()
    if (path_left == 100):
        end_position = get("position") + (tilesize * path_right) * Vector2(1, -0.2)
    else:
        end_position = get("position") + (tilesize * path_left) * Vector2(-1, 0.2)

    $Tween.interpolate_property(self, "position", get("position"), 
                                end_position, 2,
                                Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    $Tween.start()
    print ("end")


func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_StopTimer_timeout():
    linear_velocity = Vector2(0, 0)
