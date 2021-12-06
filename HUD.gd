extends Node



func _process(delta):
	pass


func _on_Player_perder():
	$ResetTimer.start()


func _on_ResetTimer_timeout():
	get_tree().call_deferred("reload_current_scene")
