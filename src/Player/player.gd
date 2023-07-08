class_name Player
extends BaseObject

signal bullet_shot(bullet_scene, location, direction, velocity)

@onready var muzzle = $Muzzle
@onready var bullet_scene = preload("res://Bullet/bullet.tscn")

@export var bullet_velocity = 2048

const COOLDAWN = 0.17
var timer = COOLDAWN


func _ready():
	durability_cap = 4000 * material_density
	durability = durability_cap
	my__info()

func _process(delta):
	if delta > timer:
		if Input.is_action_pressed("shoot"):
			shoot()
	else:
		timer -= delta
	_move()
	_rotate()
	

func _move():
	var direction = Vector2(cos(rotation), sin(rotation))
	var boost = mass*10
	if Input.is_action_pressed("strafe_right"):
		apply_central_impulse(direction.rotated(PI/2)*boost)
	if Input.is_action_pressed("strafe_left"):
		apply_central_impulse(direction.rotated(-PI/2)*boost)
	if Input.is_action_pressed("move_forward"):
		apply_central_impulse(direction*boost)
	if Input.is_action_pressed("move_back"):
		apply_central_impulse(-direction*boost)
	if Input.is_action_pressed("anchor"):
		apply_central_impulse(-linear_velocity.normalized()*boost)

func _rotate():
	var boost = mass * 100
	if Input.is_action_pressed("rotate_right"):
		apply_torque_impulse(boost)
	if Input.is_action_pressed("rotate_left"):
		apply_torque_impulse(-boost)
	if Input.is_action_pressed("anchor"):
		apply_torque_impulse(-angular_velocity*boost)

func shoot():
	bullet_shot.emit(
		bullet_scene, 
		muzzle.global_position,
		Vector2(cos(rotation), sin(rotation)),
		bullet_velocity + linear_velocity.length()
	)
	timer = COOLDAWN
