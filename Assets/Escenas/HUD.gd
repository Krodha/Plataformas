extends CanvasLayer

func _process(_delta):
	$Dinero_player.text = "Dinero: " + str(GLOBAL.dinero)

func _on_Player_perder():
	$ResetTimer.start()

func _on_ResetTimer_timeout():
	get_tree().call_deferred("reload_current_scene")

