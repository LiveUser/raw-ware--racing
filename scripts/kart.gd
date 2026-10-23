extends CharacterBody3D

class_name Kart
@onready var cam_pivot:Node3D = $CamPivot
@onready var kart_area:Area3D = $Area3D

@export var player_number:int = 1

var turn:float = 0
var turn_rate:float = 2.8
var speed:float = 1.5
var breaking:bool = false
var accelerating:bool = false
var acceleration:float = 0
var off_road:bool = false

func _ready() -> void:
	kart_area.body_entered.connect(on_body_entered)
func on_body_entered(body:Node3D) -> void:
	if body is Road:
		off_road = false
	elif body is Grass:
		off_road = true
	else:
		pass
func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var controller_num:int = event.device + 1
		if player_number == controller_num:
			if Input.is_action_pressed("accelerate"):
				accelerating = true
				breaking = false
				acceleration = Input.get_action_strength("accelerate")
			elif Input.is_action_pressed("break"):
				accelerating = true
				breaking = true
				acceleration = Input.get_action_strength("break")
			elif Input.is_action_just_released("accelerate") || Input.is_action_just_released("break"):
				accelerating = false
				breaking = false
				velocity = Vector3.ZERO
			if Input.is_action_pressed("left"):
				turn = turn_rate * Input.get_action_strength("left")
			elif Input.is_action_pressed("right"):
				turn = -turn_rate * Input.get_action_strength("right")
			else:
				turn = 0
			#Pivot camera
			if Input.is_action_pressed("pivot_left"):
				cam_pivot.rotation_degrees.y = 180 * Input.get_action_strength("pivot_left")
			elif Input.is_action_pressed("pivot_right"):
				cam_pivot.rotation_degrees.y = -180 * Input.get_action_strength("pivot_right")
			else:
				cam_pivot.rotation_degrees.y = 0

func _physics_process(delta: float) -> void:
	#Rotate
	if velocity.length() != 0:
		if breaking:
			global_rotation.y += -turn * delta
		else:
			global_rotation.y += turn * delta
	if accelerating == true:
		velocity.z = speed
		if off_road:
			velocity.z = velocity.z * 0.5
	else:
		velocity.z = 0
		velocity.x = 0
	#Point velocity vector in the same direction as rotation
	var x_velocity:float = sin(global_rotation.y) * velocity.z
	var z_velocity:float = cos(global_rotation.y) * velocity.z
	velocity.x = x_velocity * acceleration
	velocity.z = z_velocity * acceleration
	if breaking:
		velocity = -velocity
	gravity()
	move_and_slide()
func gravity() -> void:
	if !is_on_floor():
		velocity.y = -9.8
