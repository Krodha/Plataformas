extends Control



func _on_Habilidades_pressed():
	$MiniMenu.visible = false
	$MenuHabilidades.visible = true


func _on_Restart_pressed():
	get_tree().call_deferred("reload_current_scene")


func _on_Main_menu_pressed():
	get_tree().quit()


func _on_Skin_pressed():
	get_tree().call_deferred("change_scene", "res://Assets/Escenas/Chose_skin.tscn")


func _on_Quitar_pressed():
	get_tree().get_nodes_in_group("HUD")[0].get_node("Menu").visible = false
