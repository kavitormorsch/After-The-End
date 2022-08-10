extends Control


func _ready():
	pass



#func _on_Pedra1_pressed():
#	$Panel/Label.text = "Pedra1"
#
#
#func _process(_delta):
#	pass
#
#
#func _on_Pedra2_pressed():
#	$Panel/Label.text = "Pedra2"
#
#
#func _on_Button_pressed():
#	if $Panel/Label.text == "Pedra1":
#		variaveisglobais.tile_escolhida = 0
#	if $Panel/Label.text == "Pedra2":
#		variaveisglobais.tile_escolhida = 1
#	if $Panel/Label.text == "Espada de Ferro" and variaveisglobais.recursos >= 10:
#		variaveisglobais.arma = 1
#		variaveisglobais.recursos -= 10
#		GerenciadorSinais.emit_signal("arma_feita")
#	if $Panel/Label.text == "Espada de Titanio" and variaveisglobais.recursos >= 20:
#		variaveisglobais.arma = 2
#		variaveisglobais.recursos -= 20
#		GerenciadorSinais.emit_signal("arma_feita")
#
#
#func _on_Arma1_pressed():
#	$Panel/Label.text = "Espada de Ferro"
#
#
#func _on_Arma2_pressed():
#	$Panel/Label.text = "Espada de Titanio"
#
#func Blocos_Menu_Aberto():
#	if $Panel/Armas.visible == true:
#		$Panel/Blocos.visible = true
#		$Panel/Armas.visible = false
#
#
#func Armas_Menu_Aberto():
#	if $Panel/Blocos.visible == true:
#		$Panel/Armas.visible = true
#		$Panel/Blocos.visible = false
