class_name Bullet
extends BaseObject

var damage_boost = 5

func _ready():
	var vol = $CollisionShape2D.shape.size
	mass = (vol.x * vol.y * vol.y) * 4.5 # density of bullet
	durability_cap = float(mass) / damage_boost # dur of bullet
	durability = durability_cap
	my__info()

func _process(delta):
	if (linear_velocity.length() < 1/delta):
		destruct()

func damage_calculate(body):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	print("\t" + str(difference) + " its DIFF")
	var damage = difference * get_process_delta_time()
	return damage * damage_boost
