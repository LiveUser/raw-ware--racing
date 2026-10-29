extends Node3D

#Level name
@onready var level_name:Label3D = $LevelName
#Levels
@onready var test_track:Node3D = $Display/TestTrack
@onready var farmlands:Node3D = $Display/Farmlands
@onready var city:Node3D = $Display/City
var amount_of_levels:int = 3

var selected_level:int = 0

func _ready() -> void:
	#Set first level as visible
	test_track.visible = true
	farmlands.visible = false
	city.visible = false
	level_name.text = "Test Track"
func _physics_process(delta: float) -> void:
	#Select level
	if Input.is_action_just_pressed("right"):
		selected_level += 1
		#Reset if exceeds available levels
		if (amount_of_levels - 1) < selected_level:
			selected_level = 0
		update_level_preview()
	elif Input.is_action_just_pressed("left"):
		selected_level -= 1
		#Move to last level if less than 1
		if selected_level < 0:
			selected_level = (amount_of_levels - 1)
		update_level_preview()
	else:
		pass
	#Load level
	if Input.is_action_just_pressed("confirm"):
		load_level()
	#Exit Game
	if Input.is_action_just_pressed("back"):
		get_tree().quit()
func update_level_preview() -> void:
	if selected_level == 0:
		test_track.visible = true
		farmlands.visible = false
		city.visible = false
		level_name.text = "Test Track"
	elif selected_level == 1:
		test_track.visible = false
		farmlands.visible = true
		city.visible = false
		level_name.text = "Farmlands"
	elif selected_level == 2:
		test_track.visible = false
		farmlands.visible = false
		city.visible = true
		level_name.text = "City"
	else:
		pass
func load_level() -> void:
	if selected_level == 0:
		var level = load("res://scenes/worlds/test_track.tscn")
		get_tree().change_scene_to_packed(level)
	elif selected_level == 1:
		var level = load("res://scenes/worlds/farmlands.tscn")
		get_tree().change_scene_to_packed(level)
	elif selected_level == 2:
		var level = load("res://scenes/worlds/city.tscn")
		get_tree().change_scene_to_packed(level)
	else:
		pass
