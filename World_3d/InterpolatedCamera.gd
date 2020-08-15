extends InterpolatedCamera

var time = 0
var period = 0.3
var magnitude = 0.2

func _ready():
    PlayerData.connect("shake_camera", self, "on_camera_shake")

func on_camera_shake():
    var campos = get_translation()
    while time < period:
        time += get_process_delta_time()
        time = min(time, period)
        
        var offset = Vector3()
        offset.x = rand_range(-period, period)
        offset.y = rand_range(-period, period)
        offset.z = 0
        
        var newcampos = campos
        newcampos += offset
        set_translation(newcampos)
        
        yield(get_tree(), "idle_frame")
    
    set_translation(campos)
    time = 0
    
