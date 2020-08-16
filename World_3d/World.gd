extends Spatial

var Person2 = preload("res://People_3d/Person2.tscn")
export (PackedScene) var Coin
onready var track: GridMap = $Track
onready var platform: GridMap = $Platform
onready var HUD: Control = $HUD
var total_people: int = 30
var add_platform_tile: int = 5
var del_platform_tile: int = -1
var add_railway_tile: int  = 409
var del_railway_tile: int = 9
var angle: float
var person_rot: Vector3
var direction_to: Vector3
var personholder: Spatial
var person: Area
var coin: Area
#original values = [-7.5, -0.5, 6.5, 13.5]
var coin_x_coordinate = [-7.1, -0.1, 6.9, 13.9]

func _ready():
    randomize()  
    for i in range(total_people): 
#        if (i%2 == 0):
#            person = Person1.instance()
#        else:
        personholder = Person2.instance()
        person = personholder.get_node("People")
        coin = Coin.instance()
        coin.translation = Vector3 (coin_x_coordinate[randi() % coin_x_coordinate.size()],
                                    0, -1*(randi() % 1100 + 50))
        person.speed = person.speedlist.keys()[randi() % person.speedlist.keys().size()]
        person.translation = Vector3(randi() % 28 + -10, 0, 
                                   -1*(randi() % 1100 + 50))
        person.stop_pos = Vector3(randi() % 28 + -10, 0, 
                                -1*(randi() % 1100 + 50))

        direction_to = person.translation.direction_to(person.stop_pos)

        angle = atan2(direction_to.x, direction_to.z)
        person_rot = person.get_rotation()
        person_rot.y = angle
        person.set_rotation(person_rot)
        add_child(personholder)
        person.set_start_timer()
        add_child(coin)


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
