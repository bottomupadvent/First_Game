extends RigidBody

var velocity: Vector3 = Vector3(0, 0, -28)
#signal entered_dabba_area(dabba)
#signal exited_dabba_area

func _ready():
    linear_velocity = velocity

## Same function for all areas of train dabbas when entered
#func _on_Area_body_entered(body, dabba):
#    print ("something")
#    emit_signal("entered_dabba_area", dabba)
#
## Same function for all areas of train dabbas when exited
#func _on_Area_body_exited(body):
#    emit_signal("exited_dabba_area")
