extends Control

var coins: int = 1
onready var GameTimer: Timer = $GameTimer
onready var GameTimerLabel: Label = $GameTimerLabel
onready var CoinLabel: Label = $CoinLabel

func _process(_delta):
    GameTimerLabel.text = str(int(GameTimer.get_time_left()))

func coin_connect_signal(coin):
    coin.connect("coin_collected", self, "_on_Coin_coin_collected")

func _on_Coin_coin_collected():
    CoinLabel.text = str(coins)
    coins += 1
