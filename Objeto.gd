extends KinematicBody2D

var velocidade = Vector2.ZERO
var dano_objeto = 10
var velocidade_movimento = 15

var atirado = false
var alvo
var alvo2 = Vector2()


func _ready():
	GerenciadorSinais.connect("atirou_objeto", self, "_Player_Atirou")
	GerenciadorSinais.connect("puxou_objeto", self, "_Puxado")

func _process(_delta):
	velocidade = move_and_slide(velocidade, Vector2.UP)
	if variaveisglobais.no_jogador == true:
		alvo2 = variaveisglobais.player_posicao + variaveisglobais.objeto_referencia
	if variaveisglobais.no_jogador == true and position.distance_to(alvo2) > 10:
		position = position.linear_interpolate(alvo2, 0.1)

	if atirado == true:
		#position = position.linear_interpolate(alvo, 0.1)
		var direction = (alvo - alvo2).normalized()
		position += velocidade_movimento * direction
		set_collision_mask_bit(3, true)
		$Area2D/objetoAtaqueColisao.disabled = false
	if is_on_floor() and atirado == true:
		queue_free()


func _on_Objeto_mouse_entered():
	variaveisglobais.em_objeto = true


func _on_Objeto_mouse_exited():
	variaveisglobais.em_objeto = false


func _Puxado():
	if variaveisglobais.no_jogador == false:
		variaveisglobais.no_jogador = true


func _Player_Atirou():
	atirado = true
	alvo = get_global_mouse_position()
	variaveisglobais.no_jogador = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("Inimigo"):
		GerenciadorSinais.emit_signal("objeto_acertou_inimigo", dano_objeto)
		queue_free()
