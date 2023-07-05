class_name Player
extends BaseObject

signal bullet_shot(bullet_scene, location)

@onready var bullet_scene = preload("res://Bullet/bullet.tscn")
@onready var muzzle = $Muzzle

@export var bullet_velocity = 1000

func _move():
	var direction = Vector2(cos(rotation), sin(rotation))
	var boost = mass*(mass/10)
	if Input.is_action_pressed("strafe_right"):
		apply_central_impulse(direction.rotated(-PI/2)*boost)
	if Input.is_action_pressed("strafe_left"):
		apply_central_impulse(direction.rotated(PI/2)*boost)
	if Input.is_action_pressed("move_forward"):
		apply_central_impulse(direction*boost)
	if Input.is_action_pressed("move_back"):
		apply_central_impulse(-direction*boost)
	if Input.is_action_pressed("anchor"):
		apply_central_impulse(-linear_velocity.normalized()*boost)

func _rotate():
	var boost = mass*mass
	if Input.is_action_pressed("rotate_right"):
		apply_torque_impulse(boost)
	if Input.is_action_pressed("rotate_left"):
		apply_torque_impulse(-boost)
	if Input.is_action_pressed("anchor"):
		apply_torque_impulse(-angular_velocity*boost)

func shoot():
	bullet_shot.emit(
		bullet_scene, 
		muzzle.global_position
	)

func _process(delta):
	_move()
	_rotate()
	if Input.is_action_pressed("shoot"):
		shoot()
	
