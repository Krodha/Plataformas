extends KinematicBody2D

const SUELO = Vector2(0,-1)
const JUMP_HEIGH = 750
const GRAVEDAD = 20
onready var saltos : int
onready var can_move : bool = true
onready var can_jump : bool = true
onready var bala_velocidad = 2000
var movimiento : Vector2
export (int) var velocidad 
export (PackedScene) var bala
signal perder

func _ready():
	if GLOBAL.player_skin == 2:
		$AnimatedSprite.play("AZUL")
	if GLOBAL.player_skin == 1:
		$AnimatedSprite.play("ROJO")


func _process(delta):
	_is_on_floor(delta)
	_movement()


func _physics_process(delta):

	if Input.is_action_pressed("exit"):
		get_tree().quit()

	movimiento.y += GRAVEDAD * 100 * delta
	if $RayCast2D.is_colliding():
		saltos = 0
		can_jump = true
	
	if saltos >= 1:
		can_jump = false
	$BalaPosition.look_at(get_global_mouse_position())

func get_axis() -> Vector2:
	var axis = Vector2()
	axis.x = int(Input.is_action_pressed("ui_d")) - int(Input.is_action_pressed("ui_a"))
	return axis


func _movement():
	if can_move:
		if get_axis().x != 0:
			movimiento.x = get_axis().x * velocidad
		else:
			movimiento.x = lerp(movimiento.x, 0, 0.2)
		
		if Input.is_action_just_pressed("Espacio") and can_jump:
			movimiento.y -= JUMP_HEIGH
			saltos += 1
		if Input.is_action_just_pressed("Click_izq"):
			disparar()


func _is_on_floor(delta):
	position += movimiento * delta
	movimiento = move_and_slide(movimiento, SUELO)


func _on_Player_vs_enemy_collision(body):
	if body.is_in_group("Enemy"):
		can_move = false
		emit_signal("perder")


func _on_Nube_SaltoExtra():
	saltos -=1

func disparar():
	var bala_instance = bala.instance()
	bala_instance.position = get_global_position()
	bala_instance.rotation_degrees = $BalaPosition.rotation_degrees
	bala_instance.apply_impulse(Vector2(),Vector2(bala_velocidad,0).rotated($BalaPosition.rotation))
	get_tree().get_root().call_deferred("add_child", bala_instance)
