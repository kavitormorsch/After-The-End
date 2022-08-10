extends Control


func _ready():
	GerenciadorSinais.connect("arma_feita", self, "Mudar_Arma_HUD")


func _process(delta):
	$VBoxContainer/Panel2/Label.text = "Recursos:" + String(variaveisglobais.recursos)

func Mudar_Arma_HUD():
	if variaveisglobais.arma == 1:
		$Panel/TextureRect.texture = load("res://Assets/armas/sword_iron.png")
	if variaveisglobais.arma == 2:
		$Panel/TextureRect.texture = load("res://Assets/armas/sword_silver.png")
