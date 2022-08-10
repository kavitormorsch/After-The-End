extends CanvasLayer

signal mudou_cena

export (String) var nome_cena = "MenuPrincipal"


func limpeza():
	queue_free()

func _on_ComecarJogo_pressed():
	emit_signal("mudou_cena", nome_cena)


func _on_sair_pressed():
	get_tree().quit()


func _on_carregar_pressed():
	$menudesave.visible = true
