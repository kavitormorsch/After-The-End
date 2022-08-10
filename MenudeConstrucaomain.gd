extends CanvasLayer

var aberto = false

func _ready():
	pass

func esconder():
		aberto = false
		$Control.visible = false

func aparecer():
	if variaveisglobais.nao_abra == false and variaveisglobais.em_menu_principal == false:
		aberto = true
		$Control.visible = true

func _on_Pedra1_pressed():
	print("weart")
	$Control/Panel/Label.text = "Pedra1"
	

func _process(_delta):
	pass


func _on_Pedra2_pressed():
	print("weart")
	$Control/Panel/Label.text = "Pedra2"


func _on_Button_pressed():
	if $Control/Panel/Label.text == "Pedra1":
		variaveisglobais.tile_escolhida = 0
	if $Control/Panel/Label.text == "Pedra2":
		variaveisglobais.tile_escolhida = 1
	if $Control/Panel/Label.text == "Espada de Ferro" and variaveisglobais.recursos >= 10:
		variaveisglobais.arma = 1
		variaveisglobais.recursos -= 10
		GerenciadorSinais.emit_signal("arma_feita")
	if $Control/Panel/Label.text == "Espada de Titanio" and variaveisglobais.recursos >= 20:
		variaveisglobais.arma = 2
		variaveisglobais.recursos -= 20
		GerenciadorSinais.emit_signal("arma_feita")



func _on_Arma1_pressed():
	$Control/Panel/Label.text = "Espada de Ferro"


func _on_Arma2_pressed():
	$Control/Panel/Label.text = "Espada de Titanio"

func Blocos_Menu_Aberto():
	print("weart")
	if $Control/Panel/Armas.visible == true:
		$Control/Panel/Blocos.visible = true
		$Control/Panel/Armas.visible = false


func Armas_Menu_Aberto():
	print("weart")
	if $Control/Panel/Blocos.visible == true:
		$Control/Panel/Armas.visible = true
		$Control/Panel/Blocos.visible = false
