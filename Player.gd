extends KinematicBody2D

const SUELO = Vector2(0,-1)
const JUMP_HEIGH = -750
const GRAVEDAD = 20
onready var saltos : int
onready var can_jump : bool = true
var movimiento : Vector2
export (int) var velocidad 
signal perder

func _process(delta):
	_is_on_floor(delta)
	_movement()


func _physics_process(delta):
	
	movimiento.y += GRAVEDAD * 100 * delta
	if $RayCast2D.is_colliding():
		saltos = 0
		can_jump = true
	
	if saltos == 1:
		can_jump = false




func _movement():
	
	if Input.is_action_just_pressed("Espacio") and can_jump:
		movimiento.y += JUMP_HEIGH
		saltos += 1
	
	if Input.is_action_pressed("ui_a"):
		movimiento.x -= 10
	
	if Input.is_action_pressed("ui_d"):
		movimiento.x += 10
	
	if Input.is_action_pressed("exit"):
		get_tree().quit()




func _is_on_floor(delta):
	
	position += movimiento * delta
	movimiento = move_and_slide(movimiento, SUELO)
	




func _on_Player_vs_enemy_collision(body):
	
	if body.is_in_group("Enemy"):
		emit_signal("perder")
	



func _on_Nube_SaltoExtra():
	saltos -=1
