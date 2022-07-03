extends Node

func _on_Rojo_pressed():
	GLOBAL.player_skin = 1
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().call_deferred("change_scene", "res://Assets/Escenas/Mapa.tscn")

func _on_Azul_pressed():
	GLOBAL.player_skin = 2
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().call_deferred("change_scene", "res://Assets/Escenas/Mapa.tscn")
