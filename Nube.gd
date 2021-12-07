extends Area2D

signal SaltoExtra


func _on_Nube_body_entered(body):
	if body is KinematicBody2D:
		emit_signal("SaltoExtra")
