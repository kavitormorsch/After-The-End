extends KinematicBody2D

var velocidade = Vector2()
var pulo_forca = 250
var gravidade = 500
var vida_maxima = 10
var vida = 10

#Variaveis Combate
var empurrao_ini_x = 100
var empurrao_ini_y = 100
var dano = 0
var durabilidade = 0
var arma = null

enum estados {parado, andando, pulando, voando, atacando}
var estado = estados.parado
var atacando = false
var voando = false
var level_atual = null

func _ready():
	GerenciadorSinais.connect("acertou_player", self, "_Inimigo_Acertou")


func _process(delta):
	#if Input.is_action_pressed("Debug"):
		#print(variaveisglobais.materiais)
		#print(estado, velocidade, variaveisglobais.objeto_referencia)
	
	velocidade = move_and_slide(velocidade, Vector2.UP)
	velocidade.x = 0
	variaveisglobais.player_posicao = global_position
	
	
	if estado != estados.voando:
		velocidade.y += gravidade * delta
	else:
		velocidade.y = 0
	if !Input.is_action_pressed("Esquerda") and !Input.is_action_pressed("Direita") and atacando == false and voando == false:
		mudar_estados(0)
	if Input.is_action_pressed("Esquerda") and atacando == false and voando == false or Input.is_action_pressed("Direita") and atacando == false and voando == false:
		mudar_estados(1)
	if Input.is_action_just_pressed("Pular") and is_on_floor():
		mudar_estados(2)
	if Input.is_action_just_pressed("Voar") and !is_on_floor() and voando == false:
		voando = true
	elif Input.is_action_just_pressed("Voar") and voando == true:
		voando = false
	if voando == true:
		mudar_estados(3)
	if Input.is_action_just_pressed("Ataque") and atacando == false and estado != estados.voando:
		mudar_estados(4)
	if Input.is_action_just_pressed("Botao_Direito") and variaveisglobais.em_objeto == true:
		GerenciadorSinais.emit_signal("puxou_objeto")
	if Input.is_action_just_pressed("Botao_Direito") and variaveisglobais.no_jogador == true and variaveisglobais.em_objeto == false:
		GerenciadorSinais.emit_signal("atirou_objeto")
	if vida == 0:
		queue_free()
	

func pegar_stats_save():
	return {
		"nome" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : global_position.x,
		"pos_y" : global_position.y,
		"vida" : vida,
		"vida_maxima" : vida_maxima,
		"level_atual" : variaveisglobais.cena_nome
	}

func carregar_stats_save(stats):
	global_position = Vector2(stats.pos_x, stats.pos_y)
	vida = stats.vida
	vida_maxima = stats.vida_maxima

func pulo():
	velocidade.y = -pulo_forca

func andar():
	if $AnimatedSprite.animation != "Ataque":
		$AnimatedSprite.play("Andar")
	if Input.is_action_pressed("Esquerda") and voando == false:
		velocidade.x -= 80
		$AnimatedSprite.flip_h = false
		$ReferenciaObjeto.position.x = 14
		
	if Input.is_action_pressed("Direita") and voando == false:
		velocidade.x += 80
		$AnimatedSprite.flip_h = true
		$ReferenciaObjeto.position.x = -14


func voo():
	if Input.is_action_pressed("Cima") and voando == true:
		velocidade.y -= 80
	if Input.is_action_pressed("Baixo") and voando == true:
		velocidade.y += 80
	if Input.is_action_pressed("Esquerda") and voando == true:
		velocidade.x -= 80
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("Direita") and voando == true:
		velocidade.x += 80
		$AnimatedSprite.flip_h = true

func ataque():
	checar_arma()
	$AnimatedSprite.play ("Ataque")
	$AreaAtaque/AtaqueCollisao.disabled = false
	if Input.is_action_just_pressed("Ataque"):
		atacando = true
	if $AnimatedSprite.flip_h == false:
		$AreaAtaque/AtaqueCollisao.position.x = -30
		velocidade.x -= 500
	else:
		$AreaAtaque/AtaqueCollisao.position.x = 0
		velocidade.x += 500
	

func checar_arma():
	if durabilidade == 0:
		dano = 1
	if variaveisglobais.arma == 1:
		dano = 3
		durabilidade = 5
	if variaveisglobais.arma == 2:
		dano = 10
		durabilidade = 10

func mudar_estados(estado_novo):
	estado = estado_novo
	
	match estado:
		estados.parado:
			$AnimatedSprite.play("Inato")
		estados.andando:
			andar()
		estados.pulando:
			pulo()
		estados.voando:
			voo()
		estados.atacando:
			ataque()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Ataque":
		atacando = false
		$AreaAtaque/AtaqueCollisao.disabled = true
		mudar_estados(0)




func _on_AreaAtaque_body_entered(body):
	if body.is_in_group("Inimigo"):
		GerenciadorSinais.emit_signal("acertou", dano, empurrao_ini_x, empurrao_ini_y)
		durabilidade -= 1



func _Inimigo_Acertou(dano_inimigo,knockback_player_x, knockback_player_y):
	vida -= dano_inimigo
	if $AnimatedSprite.flip_h == true:
		velocidade.x -= knockback_player_x
	if $AnimatedSprite.flip_h == false:
		velocidade.x += knockback_player_x
	velocidade.y -= knockback_player_y
