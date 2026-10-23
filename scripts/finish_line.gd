extends Node3D

@onready var canvas:CanvasLayer = $CanvasLayer
@onready var finish_line:Area3D = $Area3D
@onready var text:Label = $CanvasLayer/Label

var game_over:bool = false

func _ready() -> void:
	canvas.visible = false
	finish_line.body_entered.connect(body_entered)
func body_entered(body:Node3D)->void:
	if game_over == false && body is Kart:
		canvas.visible = true
		game_over = true
		text.text = "Player " + str((body as Kart).player_number) + " Won"
