extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var bullet_container = $BulletContainer

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.bullet_shot.connet(_on_player_bullet_shot)
	
func _on_player_bullet_shot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.position = location
	bullet_container.add_child(bullet)
