extends KinematicBody2D

var vidas_calavera = 10
var movimiento : Vector2
var can_move : bool = false
export (PackedScene) var balaEnemy
onready var calavera = get_tree().get_nodes_in_group("Enemy")[3]
onready var jugador = get_tree().get_nodes_in_group("Player")[0]
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
onready var bala_velocidad = 2000

func _process(delta):
	position += movimiento * delta
	movimiento_ctrl()

func get_axis() -> Vector2:
	var axis : Vector2
	axis = jugador.global_position - calavera.global_position + Vector2(400,-500)
	axis.normalized()
	return axis

func movimiento_ctrl():
	if can_move:
		if get_axis() != Vector2.ZERO:
			movimiento = get_axis().normalized() * Vector2(300,300)
		else:
			movimiento = Vector2.ZERO
	
	if get_axis().x - 400 <= 0:
		$Sprite.flip_h = false
	elif get_axis().x - 400 >= 0:
		$Sprite.flip_h = true
	
	if vidas_calavera <= 0:
		queue_free()
	
	$Position2D.look_at(jugador.global_position)

func _on_HitBox_body_entered(body):
	if body.is_in_group("Proyectil"):
		$AnimationPlayer.play("Daño")
		vidas_calavera -= 1


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true

func disparo():
	var bala = balaEnemy.instance()
	bala.position = global_position
	bala.rotation_degrees = $Position2D.rotation_degrees
	bala.apply_impulse(Vector2(),Vector2(bala_velocidad,0).rotated($Position2D.rotation))
	get_tree().get_root().call_deferred("add_child", bala)


func random(min_val,max_val):
	rng.randomize()
	var random = rng.randf_range(min_val,max_val)
	return random


func _on_Disparo_timeout():
	disparo()
	$Disparo.wait_time = random(2.5,5)
	$Disparo.start()
