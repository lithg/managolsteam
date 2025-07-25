extends Control

@onready var nome_label = $ClubHeader/NomeClube
@onready var saldo_label = $ClubHeader/Saldo
@onready var creditos_label = $ClubHeader/Creditos
@onready var qtd_socios_label = $ClubHeader/QtdSocios
@onready var fundacao_label = $ClubHeader/Fundacao
@onready var clan_name = $ClubHeader/ClanNome
@onready var badge_vip = $ClubHeader/VIPBadge

@onready var navbar = $NavBar/NavBarBackground/NavBar
@onready var botao_hamburguer = $NavBar/NavBarBackground/BotaoMenuHamburguer

var menu_visivel := true  # Estado interno para toggle

func _ready():
	carregar_dados_do_clube()
	# ajustar_layout()
	get_viewport().size_changed.connect(ajustar_layout)

	# Clica no botão de hambúrguer para alternar navbar
	botao_hamburguer.pressed.connect(toggle_navbar)

func carregar_dados_do_clube():
	nome_label.text = "%s" % Global.nome_clube
	saldo_label.text = "💰 R$ %s" % Global.saldo
	creditos_label.text = "⭐ %s créditos" % Global.creditos
	qtd_socios_label.text = "👥 %s sócios" % Global.quantidade_socios
	fundacao_label.text = "Fundado em: %s" % Global.fundacao
	clan_name.text = "%s" % Global.clan_name
	badge_vip.visible = Global.possui_managol_plus

func ajustar_layout():
	var largura = get_viewport_rect().size.x
	var usar_menu_colapsado = largura < 900

	navbar.visible = not usar_menu_colapsado
	botao_hamburguer.visible = usar_menu_colapsado
	menu_visivel = navbar.visible

func toggle_navbar():
	menu_visivel = !menu_visivel
	navbar.visible = menu_visivel
