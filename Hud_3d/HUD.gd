extends Control

var coins: int = 1

func _ready():
#    var coin = get_tree().get_root().find_node("Coin", true, false)
#    coin.connect("coin_collected", self, "_on_Coin_coin_collected")
    pass

func _on_Coin_coin_collected():
    print ("coin collected")
    $Label.text = String(coins)
    coins += 1
