extends TextureRect

var dragging = false
var offset = Vector2.ZERO

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				offset = get_global_mouse_position() - global_position
			else:
				dragging = false
	
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - offset

func salvar_posicao():
	var dados = {
		"posicao": global_position
	}
	var file = FileAccess.open("user://posicao_jogador_1.save", FileAccess.WRITE)
	file.store_var(dados)
	file.close()
