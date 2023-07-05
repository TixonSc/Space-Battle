class_name Bullet
extends BaseObject

func _on_body_entered(body: BaseObject):
	var difference = body.linear_velocity.distance_to(linear_velocity)
	body.take_damage(difference * mass)
	destruct()

func _process(delta):
	if (linear_velocity.length() < 1/delta):
		destruct()
