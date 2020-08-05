extends Spatial

export (PackedScene) var Person1
export (PackedScene) var Person2
onready var track = $Track
onready var platform = $Platform
var add_platform_tile = 5
var del_platform_tile = -1
var add_railway_tile = 409
var del_railway_tile = 9
var person

func _ready():
    randomize()  
    for i in range($People.total_people): 
        if (i%2 == 0):
            person = Person1.instance()
        else:
            person = Person2.instance()
        add_child(person)
        person.translation = Vector3(randi() % 35 + -15, 0, 
                                   -1*(randi() % 1100 + 50))
#        var start_pos_vec2 = Vector2(person.translation.x, person.translation.z)
        person.stop_pos = Vector3(randi() % 35 + -15, 0, 
                                -1*(randi() % 1100 + 50))

        var direction_to = person.translation.direction_to(person.stop_pos)

#        var stop_pos_vec2 = Vector2(person.stop_pos.x, person.stop_pos.z)                            
        var angle = atan2(direction_to.x, direction_to.z)
        var person_rot = person.get_rotation()
        person_rot.y = angle
        person.set_rotation(person_rot)
        # print ("rotation_degrees.y ", person.rotation_degrees.y)
        # print (person.stop_pos)
        person.set_start_timer()


func _on_Restart_pressed():
    get_tree().reload_current_scene()

func _on_AddPlatformTile_timeout():
    platform.set_cell_item(10, 0, add_platform_tile, 0)
    add_platform_tile += 1

func _on_RemovePlatformTile_timeout():
    platform.set_cell_item(10, 0, del_platform_tile, -1)
    del_platform_tile += 1

func _on_AddRailwayTile_timeout():
    track.set_cell_item(16, 0, -1 * add_railway_tile, 0)
    add_railway_tile += 25
    
func _on_RemoveRailwayTile_timeout():
    track.set_cell_item(16, 0, -1 * del_railway_tile, -1)
    del_railway_tile += 25
