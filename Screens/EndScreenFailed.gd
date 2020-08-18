extends Control

onready var FinalScore: Label = $FinalScore

func _ready():
    FinalScore.text = FinalScore.text % [1, PlayerData.coins]
    
