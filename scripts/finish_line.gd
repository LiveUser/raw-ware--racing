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
func _input(event: InputEvent) -> void:
	var controller_num:int = event.device + 1
	if controller_num == 1 && event.is_action_pressed("confirm") && game_over:
		get_tree().reload_current_scene()
	elif controller_num == 1 && event.is_action_pressed("back") && game_over:
		#TODO: Load start screen
		pass
	else:
		pass
