extends RigidBody2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") or body is TileMap:
		queue_free()
