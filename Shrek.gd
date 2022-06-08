extends KinematicBody2D

export (int) var velocidad 
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var shrek = get_tree().get_nodes_in_group("Shrek")[0]
onready var movimiento : Vector2
const SUELO = Vector2(0,-1)
const GRAVEDAD = 35

func _process(delta):
	_is_on_floor(delta)
	movimiento_ctrl()

func _is_on_floor(delta):
	position += movimiento * delta
	movimiento = move_and_slide(movimiento, SUELO)
	movimiento.y += GRAVEDAD

func movimiento_ctrl():
	if player.global_position.x >= shrek.global_position.x:
		movimiento.x += 5
	else:
		 movimiento.x -= 5
		
	
	
	
