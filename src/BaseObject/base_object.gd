class_name BaseObject
extends RigidBody2D

@export var strength_cap = 1

var strength

func _init():
	strength = strength_cap

func destruct():
	queue_free()

func take_damage(damage):
	if (damage > strength):
		destruct()
	else:
		strength -= damage

func _on_BaseObject_body_entered(body: BaseObject):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	take_damage(difference * body.mass)
	body.take_damage(difference * mass)

func _physics_process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)
	if collision_info:
		linear_velocity = linear_velocity.bounce(collision_info.normal)
