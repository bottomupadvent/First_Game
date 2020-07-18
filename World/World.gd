extends Node2D

export (PackedScene) var People
var paths = [1, 2, 3, 4]

func _ready():
    randomize()  
    for i in range($People.total_people): 
        var person = People.instance()
        
        person.path = paths[randi() % paths.size()]

        if (person.path == 1):
            $Path1/PathFollow2D.offset = randi()
            person.position = $Path1/PathFollow2D.position
            # If on 1st path it can move up down and right
            person.direction = randi() % 3 + 1
            if (person.direction == 2):
                person.path_right = randi() % 3 + 1
                
        elif (person.path == 2):
            $Path2/PathFollow2D.offset = randi()
            person.position = $Path2/PathFollow2D.position
            # If on 2nd path it can move all directions
            person.direction = randi() % 4 + 1
            if (person.direction == 2):
                person.path_right = randi() % 2 + 1
            elif (person.direction == 4):
                person.path_left = 1
    
        elif (person.path == 3):
            $Path3/PathFollow2D.offset = randi()
            person.position = $Path3/PathFollow2D.position
            # If on 3rd path it can move all directions
            person.direction = randi() % 4 + 1
            if (person.direction == 2):
                person.path_right = 1
            elif (person.direction == 4):
                person.path_left = randi() % 2 + 1   

        else:
            $Path4/PathFollow2D.offset = randi()
            person.position = $Path4/PathFollow2D.position
            # If on 4th path it can only move up down and left
            person.direction = 1
            if (person.direction == 4):
                person.path_left = randi() % 3 + 1

        person.set_parameters()
        add_child(person)

    

func new_game():
#    $Player.start($StartPosition.position)
#    $Player.show()
    pass

func game_over():
    $HUD.show_game_over()
