extends Node

signal ButtonR
signal ButtonA

func _on_ButtonR_pressed():
	get_tree().emit_signal("ButtonR")
	get_tree().call_deferred("change_scene", "res://Mapa.tscn")
	


func _on_ButtonA_pressed():
	get_tree().emit_signal("ButtonA")
	get_tree().call_deferred("change_scene", "res://Mapa.tscn")
	
