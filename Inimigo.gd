extends KinematicBody2D

var vida = 10
var dano_inimigo = 5
var velocidade = Vector2.ZERO
var player = null
enum estados {parado, seguindo, atacando}
var estado = estados.parado



func _ready():
	GerenciadorSinais.connect("acertou", self, "_on_Player_acertou")
	GerenciadorSinais.connect("objeto_acertou_inimigo", self, "_Acertou_Inimigo")

func _process(delta):
	velocidade = move_and_slide(velocidade, Vector2.UP)
	velocidade.y += 500 * delta
	if vida == 0:
		queue_free()
	if player:
		mudar_estados(1)
		$AreaInimigoAtaque/InimigoColisao.disabled = false
	if player == null:
		mudar_estados(0)
		$AreaInimigoAtaque/InimigoColisao.disabled = true

func pegar_stats_save():
	return {
		"nome" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : global_position.x,
		"pos_y" : global_position.y,
		"vida" : vida
	}

func carregar_stats_save(stats):
	global_position = Vector2(stats.pos_x, stats.pos_y)
	vida = stats.vida

func mudar_estados(estado_novo):
	estado = estado_novo
	
	match estado:
		estados.parado:
			parar()
		estados.seguindo:
			seguir()
		estados.atacando:
			atacar()

func parar():
	$AnimatedSprite.play("Parado")
	velocidade.x = 0

func seguir():
	if player and is_on_floor():
		velocidade = position.direction_to(player.position) * 65
		velocidade.y = 0
		$AnimatedSprite.play("Mover")
	if position > variaveisglobais.player_posicao:
		$AnimatedSprite.flip_h = false
		$AreaInimigoAtaque/InimigoColisao.position.x = -2.5
	if position < variaveisglobais.player_posicao:
		$AnimatedSprite.flip_h = true
		$AreaInimigoAtaque/InimigoColisao.position.x = 2.5
	if velocidade.x == 0:
		$AnimatedSprite.play("Parado")

func atacar():
	GerenciadorSinais.emit_signal("acertou_player", dano_inimigo, 750, 100)
	velocidade.x = 0
	
func _on_Player_acertou(dano, empurrao_ini_x, empurrao_ini_y):
	vida -= dano
	if $AnimatedSprite.flip_h == true:
		velocidade.x -= empurrao_ini_x
	if $AnimatedSprite.flip_h == false:
		velocidade.x += empurrao_ini_x
	velocidade.y -= empurrao_ini_y


func _on_AreaInimigoAtaque_body_entered(body):
	if body.is_in_group("Player"):
		GerenciadorSinais.emit_signal("acertou_player", dano_inimigo, 750, 100)
		velocidade.x = 0
		mudar_estados(2)


func _on_AreadeDeteccao_body_entered(body):
	if body.is_in_group("Player"):
		player = body



func _on_AreadeDeteccao_body_exited(body):
	if body.is_in_group("Player"):
		player = null


func _on_AreaAtivarAtaque_body_entered(_body):
	pass


func _Acertou_Inimigo(dano_objeto):
	vida -= dano_objeto
