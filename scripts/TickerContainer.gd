extends Control

@onready var ticker_label = $TickerLabel

var velocidade := 20.0
var pausado := false

func _process(delta):
	if pausado:
		return

	ticker_label.position.y += velocidade * delta

	if ticker_label.position.y > size.y:
		ticker_label.position.y = -ticker_label.size.y

func _on_TickerLabel_mouse_entered():
	pausado = true

func _on_TickerLabel_mouse_exited():
	pausado = false
