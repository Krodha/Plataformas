extends Camera2D

onready var screensize = get_viewport_rect().size
onready var player = get_tree().get_nodes_in_group("Player")[0]


func _process(delta):
	global_position.x = player.global_position.x
	global_position.x = clamp( 960,position.x, 3072) #Amaño chapuzero para limitar el mivimiento de la cámara como en Terraria


func _on_Player_perder():
	$YOU_DIED.visible = true
