extends Control

func _ready():
	$NavBar/Home.pressed.connect(func(): mudar_tela("res://scenes/Home.tscn"))
	$NavBar/Perfil.pressed.connect(func(): mudar_tela("res://scenes/Perfil.tscn"))
	# ... repita para outros botões

func mudar_tela(caminho):
	get_tree().change_scene_to_file(caminho)
