extends TextureRect

var jogadores := []
var posicoes_iniciais := {}
const SAVE_PATH := "user://escalacao.save"

func _ready():
	jogadores = get_tree().get_nodes_in_group("jogador")
	
	# Armazenar posições iniciais dos jogadores
	for jogador in jogadores:
		posicoes_iniciais[jogador.name] = jogador.position

	carregar_posicoes()

func _on_salvar_escalacao_pressed():
	print("Botão salvar clicado!")
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	for jogador in jogadores:
		file.store_line(JSON.stringify({
			"name": jogador.name,
			"x": jogador.position.x,
			"y": jogador.position.y
		}))
	file.close()
	print("Escalação salva com sucesso!")

func _on_resetar_escalacao_pressed():
	print("Botão resetar clicado!")
	for jogador in jogadores:
		if jogador.name in posicoes_iniciais:
			jogador.position = posicoes_iniciais[jogador.name]

func carregar_posicoes():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	while not file.eof_reached():
		var data = JSON.parse_string(file.get_line())
		if typeof(data) == TYPE_DICTIONARY:
			for jogador in jogadores:
				if jogador.name == data["name"]:
					jogador.position = Vector2(data["x"], data["y"])

func _on_button_2_pressed():
	_on_salvar_escalacao_pressed()

func _on_button_pressed():
	_on_resetar_escalacao_pressed()
