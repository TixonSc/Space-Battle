extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var bullet_container = $BulletContainer

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.position = player_spawn_pos.position
	player.bullet_shot.connect(_on_player_bullet_shot)
	
func _on_player_bullet_shot(bullet_scene, location, direction: Vector2, bullet_velocity):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	bullet.rotation = direction.angle()
	bullet.linear_velocity = direction * bullet_velocity
	bullet_container.add_child(bullet)
