extends Control

onready var GameTimer: Timer = $GameTimer
onready var GameTimerLabel: Label = $GameTimerLabel
onready var CoinLabel: Label = $CoinLabel
onready var DeathLabel: Label = $DeathLabel

onready var scene_tree = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay

func _on_Pause_button_up():
    scene_tree.paused = true
    pause_overlay.visible = true
    GameTimer.paused = true

func _on_Resume_button_up():
    scene_tree.paused = false
    pause_overlay.visible = false
    GameTimer.paused = false
    
func _ready():
    PlayerData.connect("coin_collected", self, "_on_coin_collected")
    PlayerData.connect("player_died", self, "_on_player_died")
    CoinLabel.text = str(PlayerData.coins)
    DeathLabel.text = str(PlayerData.deaths)
    
func _process(_delta):
    GameTimerLabel.text = str(int(GameTimer.get_time_left()))

func _on_coin_collected():
    CoinLabel.text = str(PlayerData.coins)

func _on_player_died():
    DeathLabel.text = str(PlayerData.deaths)

func _on_GameTimer_timeout():
    get_tree().change_scene("res://Screens/EndScreenFailed.tscn")
