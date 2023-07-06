class_name Asteroid
extends BaseObject

@export var size_lvl = 6

func _ready():
	mass = circle_volume($CollisionShape2D.shape.radius) * 2.1 # density of stone
	durability_cap = float(pow(mass, 1.0/2.0)) * 2 # dur of stone
	durability = durability_cap
	my__info()

func circle_volume(radius):
	return 4*PI*pow(radius, 3) / 3
