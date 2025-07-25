extends Control

@onready var email_input = $CenterContainer/VBoxContainer/EmailInput
@onready var senha_input = $CenterContainer/VBoxContainer/SenhaInput
@onready var mensagem_erro = $CenterContainer/VBoxContainer/MensagemErro
@onready var botao_login = $CenterContainer/VBoxContainer/BotaoLogin

func _ready():
	botao_login.pressed.connect(self._fazer_login)

func _fazer_login():
	var email = email_input.text
	var senha = senha_input.text

	if email.is_empty() or senha.is_empty():
		mensagem_erro.text = "Preencha todos os campos"
		return

	var http = HTTPRequest.new()
	add_child(http)
	var headers = ["Content-Type: application/json"]
	var body = {"email": email, "senha": senha}

	http.request(
		"http://localhost:4000/api/login",
		headers,
		HTTPClient.METHOD_POST,
		JSON.stringify(body)
	)

	http.request_completed.connect(_on_request_completed)

func _on_request_completed(result, code, headers, body):
	if code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		Global.token = json.token

		# Chama rota protegida para obter dados do clube
		var request = HTTPRequest.new()
		add_child(request)
		request.request(
			"http://localhost:4000/api/usuarios/me",
			["Authorization: Bearer %s" % Global.token]
		)
		request.request_completed.connect(_on_dados_usuario)
	else:
		mensagem_erro.text = "Email ou senha incorretos."

func _on_dados_usuario(result, code, headers, body):
	if code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())

		# Salva os dados no autoload Global
		Global.nome_clube = json.clube
		Global.saldo = json.saldo
		Global.creditos = json.creditos
		Global.quantidade_socios = json.socios
		Global.fundacao = json.fundacao
		Global.possui_managol_plus = json.managolPlus


		# Agora redireciona para Home
		get_tree().change_scene_to_file("res://scenes/Home.tscn")
	else:
		mensagem_erro.text = "Erro ao carregar dados do clube."
