extends Area3D

@onready var animator:AnimationPlayer = $AnimationPlayer
@onready var timer:Timer = $Timer

var engaged:bool = false

func _ready() -> void:
	timer.timeout.connect(engage_disengage)
	body_entered.connect(slow_kart)
func engage_disengage() -> void:
	engaged = !engaged
	if engaged:
		animator.play("show")
	else:
		animator.play("hide")
func slow_kart(body:Node3D) -> void:
	if engaged && body is Kart:
		(body as Kart).slow_down_time = 2
