class_name BaseObject
extends RigidBody2D

@export var durability_cap = 1

var durability

func _ready():
	durability = durability_cap
	print(str(name) + " = " + str(durability))

func _physics_process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)

func destruct():
	queue_free()

func take_damage(damage):
	if (damage > durability):
		destruct()
	else:
		durability -= damage
		print(name + " <<< damaged on " + str(damage))
		print(name + " has >>> " + str(durability))
		print("----")

func _on_body_entered(body: BaseObject):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	take_damage(difference * body.mass)
	body.take_damage(difference * mass)
