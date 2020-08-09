extends Control

var coins = 1

func _ready():
    pass

func _on_Coin_coin_collected():
    print ("this is somehitng")
    $Label.text = str(coins)
    print ($Label.text)
    coins += 1
