extends Node

onready var cena_atual = $MenuPrincipal
onready var anim = $AnimationPlayer

var proxima_cena = null
var nome_atual_cena : String
var carregando = false

func _ready():
	Hud.esconder()
	cena_atual.connect("mudou_cena", self, "mudando_cena")
	GerenciadorSinais.connect("carregar_nivel", self, "carregar_nivel")
	variaveisglobais.cena_nome = "MenuPrincipal"

func _process(delta): 
	if Input.is_action_just_pressed("Debug"):
		print (variaveisglobais.cena_nome)

func mudando_cena(cena_atual_nome):
	variaveisglobais.em_menu_principal = true
	variaveisglobais.cena = cena_atual
	var proxima_cena_nome : String
	variaveisglobais.cena_nome = cena_atual_nome

	match cena_atual_nome:
		"MenuPrincipal":
			proxima_cena_nome = "Caverna"
			variaveisglobais.em_menu_principal = false
		"Caverna":
			proxima_cena_nome = "Caverna"
			variaveisglobais.em_menu_principal = false

	proxima_cena = load("res://" + proxima_cena_nome + ".tscn").instance()
	proxima_cena.visible = false
	nome_atual_cena = proxima_cena_nome
	variaveisglobais.cena_nome = nome_atual_cena
	add_child(proxima_cena)
	proxima_cena.connect("mudou_cena", self, "mudando_cena")
	anim.play("surgir")
	variaveisglobais.nao_abra = true
	variaveisglobais.cena = cena_atual

func pegar_stats_save():
	return {"nome" : get_filename()}

func carregar_stats_save(stats):
	if nome_atual_cena != stats.level_atual:
		carregando = true
		mudando_cena(stats.level_atual)


func carregar_nivel(level_atual):
	if nome_atual_cena != level_atual:
		mudando_cena(level_atual)

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"surgir":
			cena_atual.limpeza()
			cena_atual = proxima_cena
			cena_atual.visible = true
			Hud.aparecer()
			proxima_cena = null
			if carregando == true:
				GerenciadorSinais.emit_signal("carregou_nivel")
				carregando = false
			anim.play("desaparecer")
		"desaparecer":
			variaveisglobais.nao_abra = false
