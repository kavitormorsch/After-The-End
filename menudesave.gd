extends Control

var save_selecionada = ""

func _ready():
	pass

func _process(_delta):
	if variaveisglobais.em_menu_principal == true:
		$Panel/VBoxContainer2/Save.visible = false
	else:
		$Panel/VBoxContainer2/Save.visible = true
	
	if GerenciadorSaves.slot1 == true:
		$Panel/VBoxContainer/Slot1.text = "Save Slot 1 (Used)"
	else:
		$Panel/VBoxContainer/Slot1.text = "Save Slot 1 (Empty)"

	if GerenciadorSaves.slot2 == true:
		$Panel/VBoxContainer/Slot2.text = "Save Slot 2 (Used)"
	else:
		$Panel/VBoxContainer/Slot2.text = "Save Slot 2 (Empty)"

	if GerenciadorSaves.slot3 == true:
		$Panel/VBoxContainer/Slot3.text = "Save Slot 3 (Used)"
	else:
		$Panel/VBoxContainer/Slot3.text = "Save Slot 3 (Empty)"


func _on_Slot1_toggled(button_pressed):
	$Panel/VBoxContainer/Slot2.set_pressed_no_signal(false)
	$Panel/VBoxContainer/Slot3.set_pressed_no_signal(false)
	save_selecionada = "1"
	
func _on_Slot2_toggled(button_pressed):
	$Panel/VBoxContainer/Slot1.set_pressed_no_signal(false)
	$Panel/VBoxContainer/Slot3.set_pressed_no_signal(false)
	save_selecionada = "2"


func _on_Slot3_toggled(button_pressed):
	$Panel/VBoxContainer/Slot1.set_pressed_no_signal(false)
	$Panel/VBoxContainer/Slot2.set_pressed_no_signal(false)
	save_selecionada = "3"


func _on_Save_pressed():
	GerenciadorSaves.Save(save_selecionada)


func _on_Load_pressed():
	GerenciadorSaves.Load(save_selecionada)


func _on_Exit_pressed():
	self.visible = false
