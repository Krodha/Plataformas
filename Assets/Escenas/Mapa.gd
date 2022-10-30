extends Node

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().get_nodes_in_group("HUD")[0].get_node("Menu").visible = true
