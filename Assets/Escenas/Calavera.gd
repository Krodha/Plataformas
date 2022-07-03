extends KinematicBody2D

var vidas_calavera = 10
var movimiento : Vector2
var can_move : bool = false
export (int) var velocidad
onready var calavera = get_tree().get_nodes_in_group("Enemy")[2]
onready var jugador = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	position += movimiento * delta
	movimiento_ctrl()
	
	


func get_axis() -> Vector2:
	var axis : Vector2
	var dir : Vector2
	axis.x = jugador.global_position.x - calavera.global_position.x
	axis.y = jugador.global_position.y - calavera.global_position.y
	
	if axis.x >= 0:
		dir.x = 1
		$Sprite.flip_h = true
	elif axis.x <= 0: 
		dir.x = -1
		$Sprite.flip_h = false
	else:
		dir.x = 0
	
	if axis.y <= 0:
		dir.y = -1
	elif axis.y >= 0:
		dir.y = 1
	else:
		dir.y = 0
	return dir

func movimiento_ctrl():
	if can_move:
		if get_axis().x != 0:
			movimiento.x = get_axis().x * velocidad
		else:
			movimiento.x = 0
		
		if get_axis().y != 0:
			movimiento.y = get_axis().y * velocidad
		else:
			movimiento.y = 0
		
	if vidas_calavera <= 0:
		queue_free()

func _on_HitBox_body_entered(body):
	if body.is_in_group("Proyectil"):
		vidas_calavera -= 1


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true
