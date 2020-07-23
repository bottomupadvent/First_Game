extends Spatial

export (PackedScene) var People

func _ready():
    randomize()  
    for i in range($People.total_people): 
        var person = People.instance()
        add_child(person)
        person.translation = Vector3(randi() % 42 + -15, 1, 
                                   -1*(randi() % 200 + 50))
        var start_pos_vec2 = Vector2(person.translation.x, person.translation.z)
        print ("person.translation ", person.translation)
        person.stop_pos = Vector3(randi() % 42 + -15, 1, 
                                -1*(randi() % 200 + 50))
        
        var direction_to = person.translation.direction_to(person.stop_pos)
                                    
        var stop_pos_vec2 = Vector2(person.stop_pos.x, person.stop_pos.z)                            
        var angle = atan2(direction_to.x, direction_to.z)
        var person_rot = person.get_rotation()
        person_rot.y = angle
        person.set_rotation(person_rot)
        # print ("rotation_degrees.y ", person.rotation_degrees.y)
        # print (person.stop_pos)
        person.set_start_timer()


func _on_Button_pressed():
    get_tree().reload_current_scene()
