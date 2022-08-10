extends Node

const DIR_SAVE = "user://saves/"

var data = {}

var caminho_save = DIR_SAVE + "save.dat"
var slot1 = false
var slot2 = false
var slot3 = false

func _ready():
	ver_saves()



func ver_saves():
	var dir = Directory.new()
	if dir.file_exists(DIR_SAVE + "save1.dat"):
		slot1 = true
	else:
		slot1 = false

	if dir.file_exists(DIR_SAVE + "save2.dat"):
		slot2 = true
	else:
		slot2 = false

	if dir.file_exists(DIR_SAVE + "save3.dat"):
		slot3 = true
	else:
		slot3 = false

func _on_Exit_pressed():
	self.visible = false

func Save(save_selecionada):
	var caminho_save = DIR_SAVE + "save" + save_selecionada + ".dat"
	
	var data = {
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(DIR_SAVE):
		dir.make_dir(DIR_SAVE)
	var save = File.new()
	save.open(caminho_save, File.WRITE)
	var nodos_salvos = get_tree().get_nodes_in_group("Saved")
	
	for nodo in nodos_salvos:
		if nodo.filename.empty():
			break
			
		var data_dos_nodos = nodo.pegar_stats_save()
		save.store_line(to_json(data_dos_nodos))
	save.close()
	ver_saves()

func Load(save_selecionada):
	var caminho_save = DIR_SAVE + "save" + save_selecionada + ".dat"
	var save = File.new()
	var nodos_salvos = get_tree().get_nodes_in_group("Saved")
	
	if nodos_salvos != []:
		for nodo in nodos_salvos:
			nodo.queue_free()
	
	
	if save.file_exists(caminho_save):
		save.open(caminho_save, File.READ)
		while save.get_position() < save.get_len():
			var data_nodo = parse_json(save.get_line())
			var novo_obj = load(data_nodo.nome).instance()
			GerenciadorSinais.emit_signal("carregar_nivel", data_nodo.level_atual)
			yield(GerenciadorSinais, "carregou_nivel")
			get_node(data_nodo.parent).call_deferred("add_child", novo_obj)
			novo_obj.carregar_stats_save(data_nodo)
		

