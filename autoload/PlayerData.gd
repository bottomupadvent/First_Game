extends Node

signal coin_collected
signal player_died
signal shake_camera

var deaths: int = 3 setget set_deaths, get_deaths
var coins: int = 0 setget set_coins, get_coins
var total_people: int = 30
var people_per_timer: int = 2

func reset():
    deaths = 3
    coins = 0

func set_deaths(value: int) -> void:
    deaths = value
    emit_signal("player_died")
    emit_signal("shake_camera")

func get_deaths() -> int:
    return deaths

func set_coins(value: int) -> void:
    coins = value
    emit_signal("coin_collected")

func get_coins() -> int:
    return coins
