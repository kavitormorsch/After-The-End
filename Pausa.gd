extends CanvasLayer

var nodos = get_children()

func _ready():
	GerenciadorSinais.connect("abriu_menu", self, "Menu_Construcao_Abriu")
	visibilidade(false)


func _process(_delta):
	if Input.is_action_just_pressed("pausa") and variaveisglobais.em_menu_principal == false and variaveisglobais.nao_abra == false:
		visibilidade(!get_tree().paused)
		get_tree().paused = !get_tree().paused

	if Input.is_action_just_pressed("Menu_De_Construcao"):
		if MenudeConstrucao.aberto == false:
			MenudeConstrucao.aparecer()
			get_tree().paused = false
		elif MenudeConstrucao.aberto == true:
			MenudeConstrucao.esconder()
		if variaveisglobais.nao_abra == false and variaveisglobais.em_menu_principal == false:
			get_tree().paused = !get_tree().paused



func visibilidade(esta_visivel):
	for nodo in get_children():
		nodo.visible = esta_visivel
		$menudesave.visible = false
		MenudeConstrucao.esconder()

func _on_Button_pressed():
	visibilidade(false)
	get_tree().paused = false


func _on_Opcoes_pressed():
	pass # Replace with function body.


func _on_Save_pressed():
	$menudesave.visible = true
	
		

func Menu_Construcao_Abriu():
	get_tree().paused = !get_tree().paused

func _on_Exit_pressed():
	get_tree().quit()
