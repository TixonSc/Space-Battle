class_name BaseObject
extends RigidBody2D

@export var durability_cap = 1

var durability

func _ready():
	durability = durability_cap
	my__info()


func my__info():
	print(" _INFO_ " + str(name) + " dur: " + str(durability) + " mass: " + str(mass))	

func destruct():
	print(str(name) + " DESTRUCTED.")
	queue_free()

func take_damage(damage):
	print(name + " TAKE_DAMAGE " + str(damage))
	print(name + " DP: " + str(durability))
	if (damage > durability):
		destruct()
	else:
		durability -= damage

func damage_calculate(body):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	print("\t\t" + str(difference) + "  DIFF")
	var damage = difference * get_process_delta_time()
	return damage

func _on_body_entered(body: BaseObject):
	print(name + " _on_body_entered by " + body.name)
	body.take_damage(damage_calculate(body))
	print("_" + name + "_on_body_entered.")
