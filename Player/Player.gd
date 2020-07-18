extends KinematicBody2D

var tilesize = 83
signal swipe
signal end
var swipe_start = null
var minimum_drag = 30
export (int) var speed = 100
var screen_size 
var velocity = Vector2(-0.444, -1) # The player's movement vector.
var swiped = false
var constant_speed = Vector2(speed, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
    screen_size = get_viewport_rect().size
    constant_speed = constant_speed.rotated(deg2rad(-115))

func _physics_process(delta):
    velocity = move_and_slide(constant_speed)
    
func _input(event):
    if event.is_action_pressed("click"):
        swipe_start = get_global_mouse_position()
    if event.is_action_released("click"):
        _calculate_swipe(get_global_mouse_position())
        
func _calculate_swipe(swipe_end):
    if swipe_start == null: 
        return
    var swipe = swipe_end - swipe_start
    if abs(swipe.x) > minimum_drag:
        if swipe.x > 0:
            emit_signal("swipe", "right")
        else:
            emit_signal("swipe", "left")
        swiped = true

func cartesian_to_isometric(cartesian):
    var isometric = Vector2()
    return isometric 
    pass

func start(pos):
    position = pos
    show()
    
func end_game(position):
    emit_signal("end")
    
func _on_Player_Proto_swipe(direction):
    if direction == "right":
#        set_physics_process(false)
        position += tilesize * Vector2(1, -0.2)
 #       set_physics_process(true)
    else:
  #      set_physics_process(false)
        position += tilesize * Vector2(-1, 0.2)
   #     set_physics_process(true)
