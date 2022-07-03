extends KinematicBody2D

export (int) var velocidad 
export (bool) var can_move
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var shrek = get_tree().get_nodes_in_group("Enemy")[1]
onready var movimiento : Vector2
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
onready var vidas_shrek = 100
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

func get_axis() -> Vector2:
	var axis : Vector2
	var dir : Vector2
	axis.x = player.global_position.x - shrek.global_position.x 
	if axis.x <= 0:
		dir.x = -1
	elif axis.x >=0:
		dir.x = 1
	else:
		dir.x = 0
	return dir

func movimiento_ctrl():
	if can_move:
		if get_axis().x != 0:
			movimiento.x = get_axis().x * velocidad
		else:
			movimiento.x = 0
		if vidas_shrek <= 0:
			queue_free()


func random(min_num, max_num):
	rng.randomize()
	var random = rng.randf_range(min_num, max_num)
	return random

func _on_TimerSaltos_timeout():
	if can_move:
		movimiento.y -= JUMP_HEIGH
		$TimerSaltos.wait_time = random(1,3)
		$TimerSaltos.start()

func _on_AreaDetectar_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true

func _on_AreaDetectar_body_exited(body):
	if body.is_in_group("Player"):
		can_move = false

func _on_HitBox_body_entered(body):
	if body.is_in_group("Proyectil"):
		vidas_shrek -= 1
		$AnimationPlayer.play("Daño")


func _on_HitBox_area_entered(area):
	if area.is_in_group("PlayerhurtBox"):
		vidas_shrek -=2
		$AnimationPlayer.play("Daño")
