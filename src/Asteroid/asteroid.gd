class_name Asteroid
extends BaseObject

@export var size_lvl = 6

func _ready():
	mass = circle_volume($CollisionShape2D.shape.radius) * material_density # density of stone
	durability_cap = mass * material_density # dur of stone
	durability = durability_cap
	my__info()

func circle_volume(radius):
	return 4*PI*pow(radius, 2.3) / size_lvl
