extends KinematicBody2D

var vidas_calavera = 10
var movimiento : Vector2
var can_move : bool = false
onready var calavera = get_tree().get_nodes_in_group("Enemy")[2]
onready var jugador = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	position += movimiento * delta
	movimiento_ctrl()

func get_axis() -> Vector2:
	var axis : Vector2
	axis = jugador.global_position - calavera.global_position
	axis.normalized()
	return axis

func movimiento_ctrl():
	if can_move:
		if get_axis() != Vector2.ZERO:
			movimiento = get_axis().normalized() * Vector2(300,300)
		else:
			movimiento = Vector2.ZERO
		
	if vidas_calavera <= 0:
		queue_free()

func _on_HitBox_body_entered(body):
	if body.is_in_group("Proyectil"):
		vidas_calavera -= 1


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true
