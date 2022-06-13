extends KinematicBody2D

export (int) var velocidad 
export (bool) var can_move
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var shrek = get_tree().get_nodes_in_group("Shrek")[0]
onready var movimiento : Vector2
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
const SUELO = Vector2(0,-1)
const GRAVEDAD = 35
const JUMP_HEIGH = 750

func _process(delta):
	_is_on_floor(delta)
	movimiento_ctrl()
	
func _is_on_floor(delta):
	position += movimiento * delta
	movimiento = move_and_slide(movimiento, SUELO)
	movimiento.y += GRAVEDAD

func movimiento_ctrl():
	if can_move:
		if player.global_position.x >= shrek.global_position.x:
			movimiento.x += 5
		else:
			 movimiento.x -= 5

func random(min_num, max_num):
	rng.randomize()
	var random = rng.randf_range(min_num, max_num)
	return random

func _on_TimerSaltos_timeout():
	movimiento.y -= JUMP_HEIGH
	$TimerSaltos.wait_time = random(1,3)
	$TimerSaltos.start()


func _on_AreaDetectar_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true


func _on_AreaDetectar_body_exited(body):
	if body.is_in_group("Player"):
		can_move = false
