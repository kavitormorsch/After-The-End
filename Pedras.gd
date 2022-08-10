extends TileMap



func _process(_delta):
	var mouse_posicao = get_global_mouse_position()
	if Input.is_action_just_pressed("Botao_Direito") and variaveisglobais.em_objeto == false and variaveisglobais.no_jogador == false:
		var tile = world_to_map(mouse_posicao)
		var cell = get_cell(tile.x, tile.y)
		if cell != -1:
			set_cell(tile.x, tile.y, -1) 
			variaveisglobais.recursos += 10
		if cell == -1 and variaveisglobais.recursos >= 10 and variaveisglobais.tile_escolhida > -1:
			set_cell(tile.x, tile.y, variaveisglobais.tile_escolhida)
			variaveisglobais.recursos -= 10
