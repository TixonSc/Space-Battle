class_name BaseObject
extends RigidBody2D

@export var material_density = 1.0
@export var damage_boost = 1.0

var durability_cap
var durability

func _ready():
	_init_mass()
	durability_cap = mass * material_density
	durability = durability_cap
	my__info()


func _init_mass():
	mass = 1

func my__info():
	print("\n_SPAWN_INFO_ " + str(name) + "\n\tdur: " + str(durability) + "\n\tmass: " + str(mass))	

func destruct():
	print("\tDESTRUCTED " + str(name))
	queue_free()

func take_damage(damage):
	if (damage > durability):
		destruct()
	else:
		durability -= damage

func damage_calculate(body):
	const K = 1000
	var diff = (impulse() + body.impulse()) / (mass + body.mass)
	var damage = (
		(impulse().length() - diff.length())
		/ K * body.damage_boost / material_density * body.material_density
	)
	print("\tCALC_DAMAGE:" + str(damage))
	return damage

func impulse() -> Vector2:
	return linear_velocity * mass

func _on_body_entered(body: BaseObject):
	print("\n" + name + " _on_body_entered()")
	take_damage(damage_calculate(body))
	print("\t\t" + name + " -end.\n")
