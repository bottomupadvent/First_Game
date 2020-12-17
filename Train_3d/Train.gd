extends KinematicBody

var constant_speed: = Vector3(0, 0, -31)
#signal entered_dabba_area(dabba)
#signal exited_dabba_area

func _physics_process(delta):
    constant_speed = move_and_slide(constant_speed)

## Same function for all areas of train dabbas when entered
#func _on_Area_body_entered(body, dabba):
#    print ("something")
#    emit_signal("entered_dabba_area", dabba)
#
## Same function for all areas of train dabbas when exited
#func _on_Area_body_exited(body):
#    emit_signal("exited_dabba_area")
