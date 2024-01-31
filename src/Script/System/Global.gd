extends Node

@onready var world_json_data = Util.get_json_data(FileAccess.open("res://Resource/data/world.json", FileAccess.READ))
@onready var map_json_data = Util.get_json_data(FileAccess.open("res://Resource/data/map.json", FileAccess.READ))
var current_map
var current_map_data
var current_world
var current_world_data
var floor_type
@onready var Ui = $"/root/Main/Ui"
@onready var Camera = $"/root/Main/Camera"

#------------------------
# Function

func change_to_world(value: int) -> void:
	current_world = value
	current_world_data = world_json_data["world"][value % 100]

func change_to_map(value: int) -> void:
	current_map = value
	current_map_data = map_json_data[str(current_world)][(value % 100) - 1]
	MapManage.change_to_map(value)
	if current_map_data.has("defaultCameraZoom"):
		Camera.set_camera_zoom(current_map_data["defaultCameraZoom"])
	else:
		Camera.camera_init()

#------------------------
#	Debug
var mouse_pos
var camera_pos
var camera_zoom
