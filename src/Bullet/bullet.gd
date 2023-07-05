class_name Bullet
extends BaseObject

func _on_BaseObject_body_entered(body: BaseObject):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	body.take_damage(difference * mass)
	print("Bullet:damage")
	queue_free()
