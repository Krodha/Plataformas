extends Node

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_r"):
		get_tree().call_deferred("reload_current_scene")
