extends Camera2D

onready var screensize = get_viewport_rect().size
onready var player = get_tree().get_nodes_in_group("Player")[0]
var player_vivo : bool = true

func _ready():
	player_vivo = true

func _process(delta):
	if player_vivo:
		global_position = player.global_position
		var camara_pos 
	$YOU_DIED.global_position = get_camera_position()
func _on_Player_perder():
	$YOU_DIED.visible = true
	player_vivo = false
