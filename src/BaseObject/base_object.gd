class_name BaseObject
extends RigidBody2D

@export var durability_cap = 1

var durability

func _init():
	durability = durability_cap

func destruct():
	queue_free()

func take_damage(damage):
	if (damage > durability):
		destruct()
	else:
		durability -= damage

func _on_BaseObject_body_entered(body: BaseObject):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	take_damage(difference * body.mass)
	body.take_damage(difference * mass)

func _physics_process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)
	if collision_info:
		linear_velocity = linear_velocity.bounce(collision_info.get_normal())
