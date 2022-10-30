extends Control

func _process(_delta):
	GLOBAL.dinero = clamp(GLOBAL.dinero,0,999999999)
	$NinePatchRect/HBoxContainer/Value/Vida.text = "Nivel " + str(GLOBAL.vida_lvl)
	$NinePatchRect/HBoxContainer/Value/Fuerza.text ="Nivel " + str(GLOBAL.fuerza_lvl)
	$NinePatchRect/HBoxContainer/Value/Velocidad.text = "Nivel " + str(GLOBAL.velocidad_lvl)


func _on_Vida_pressed():
	if GLOBAL.dinero >= 150:
		GLOBAL.vida += 10
		GLOBAL.vida_lvl += 1
		GLOBAL.dinero -= 150


func _on_Fuerza_pressed():
	if GLOBAL.dinero >= 75:
		GLOBAL.fuerza +=10
		GLOBAL.fuerza_lvl += 1
		GLOBAL.dinero -= 75


func _on_Velocidad_pressed():
	if GLOBAL.dinero >= 50:
		GLOBAL.velocidad += 10
		GLOBAL.velocidad_lvl += 1
		GLOBAL.dinero -= 50


func _on_Button_pressed():
	get_tree().get_nodes_in_group("Menu")[0].get_node("MenuHabilidades").visible = false
	get_tree().get_nodes_in_group("Menu")[0].get_node("MiniMenu").visible = true
