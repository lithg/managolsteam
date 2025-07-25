extends Control

@onready var nome_clube = $NomeClube
@onready var fundacao = $FundacaoLabel
@onready var saldo_label = $SaldoLabel
@onready var creditos_label = $CreditosLabel
@onready var socios_label = $SociosLabel
@onready var logo_clube = $LogoClube
@onready var avatar = $Avatar
@onready var vip_badge = $VipIcon
# conquistas = opcional se você quiser gerar dinamicamente ícones

func _ready():
	carregar_dados_clube()

func carregar_dados_clube():
	var url = "http://localhost:4000/api/usuario/me"
	var headers = ["Content-Type: application/json"]

	var request = HTTPRequest.new()
	add_child(request)

	request.request_completed.connect(_on_request_completed)
	request.request(url, headers, HTTPClient.METHOD_GET)
	# ⚠️ Lembre-se: deve ter um token JWT salvo ou sessão válida se backend exige auth

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		print("Erro ao buscar dados do clube:", response_code)
		return

	var json = JSON.parse_string(body.get_string_from_utf8())
	if json == null:
		print("Erro ao parsear JSON")
		return

	atualizar_ui(json)

func atualizar_ui(data):
	nome_clube.text = data.clube
	fundacao.text = "Fundado em: " + formatar_data(data.fundacao)
	saldo_label.text = "💰 " + str(data.saldo)
	creditos_label.text = "💎 " + str(data.creditos)
	socios_label.text = "👥 " + str(data.socios)

	if data.managolPlus:
		vip_badge.visible = true
	else:
		vip_badge.visible = false

	if data.logo != null:
		var image = Image.new()
		image.load(data.logo)
		var tex = ImageTexture.new()
		tex.create_from_image(image)
		logo_clube.texture = tex

	# avatar = você pode fixar ou carregar da mesma forma

func formatar_data(data_iso: String) -> String:
	var data_split = data_iso.split("T")[0]  # "2024-07-24"
	var partes = data_split.split("-")       # ["2024", "07", "24"]
	if partes.size() == 3:
		var ano = partes[0]
		var mes = partes[1]
		var dia = partes[2]
		return dia + "/" + mes + "/" + ano
	return "Data inválida"

	
func _on_TextureButton_pressed():
	get_tree().change_scene_to_file("res://scenes/Escalacao.tscn")	

func _on_TextureButton2_pressed():
	get_tree().change_scene_to_file("res://scenes/Escalacao.tscn")
	
func _on_TextureButton3_pressed():
	get_tree().change_scene_to_file("res://scenes/Escalacao.tscn")
	
func _on_TextureButton4_pressed():
	get_tree().change_scene_to_file("res://scenes/Escalacao.tscn")
	
func _on_TextureButton5_pressed():
	get_tree().change_scene_to_file("res://scenes/Escalacao.tscn") # ajuste o caminho se estiver diferente
