class_name Bullet
extends BaseObject

func _ready():
	var vol = $CollisionShape2D.shape.size
	mass = (vol.x * vol.y * vol.y) * material_density # density of bullet
	durability_cap = mass * material_density
	durability = durability_cap
	my__info()

func _process(delta):
	if (linear_velocity.length() < 1/delta):
		destruct()

func _init_mass():
	var vol = $CollisionShape2D.shape.size
	mass = (vol.x * vol.y * vol.y) * material_density # density of bullet
