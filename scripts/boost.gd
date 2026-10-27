extends Area3D

func _ready() -> void:
	body_entered.connect(boost)
func boost(body:Node3D) -> void:
	if body is Kart:
		body.boost_time_remaining += 2
