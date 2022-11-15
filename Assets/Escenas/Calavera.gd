extends KinematicBody2D

export (int) var hit_damage 
var vidas_calavera = 20
var movimiento : Vector2
var can_move : bool = false
onready var calavera = get_tree().get_nodes_in_group("Enemy")[2]
onready var jugador = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	position += movimiento * delta
	movimiento_ctrl()

func get_axis() -> Vector2:
	var axis : Vector2
	axis = jugador.global_position - position + Vector2(0,-40)
	return axis.normalized()

func movimiento_ctrl():
	if can_move:
		if get_axis() != Vector2.ZERO:
			movimiento = get_axis().normalized() * Vector2(400,400)
		else:
			movimiento = Vector2.ZERO
	
	if get_axis().x <= 0:
		$Sprite.flip_h = false
	elif get_axis().x >= 0:
		$Sprite.flip_h = true
	
	if vidas_calavera <= 0:
		GLOBAL.dinero += 100
		queue_free()

func _on_HitBox_body_entered(body):
	if body.is_in_group("Proyectil"):
		$AnimationPlayer.play("Daño")
		vidas_calavera -= 1


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true
