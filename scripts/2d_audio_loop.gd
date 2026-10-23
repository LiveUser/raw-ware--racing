extends AudioStreamPlayer2D

func _ready() -> void:
	play()
	finished.connect(loop)
func loop() -> void:
	play()
