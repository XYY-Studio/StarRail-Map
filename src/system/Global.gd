extends Node

@onready var world_json_data = Util.get_json_data(FileAccess.open("res://Resource/data/world.json", FileAccess.READ))
@onready var map_json_data = Util.get_json_data(FileAccess.open("res://Resource/data/map.json", FileAccess.READ))
var current_map
var current_map_data
var current_world
var current_world_data
var floor_type
#@onready var Camera = $"/root/Main/Camera"

var current_status: int

enum status{
	IN_MAP,
	IN_HOLO,
}

#------------------------
# Function

func change_to_world(value: int) -> void:
	current_world = value
	current_world_data = world_json_data["world"][value % 100]

func change_to_map(value) -> void:
	current_map = value
	var index: int = 0
	for i in map_json_data[str(current_world)]:
		if i.has("id"):
			if i["id"] == str(value):
				current_map_data = i #map_json_data[str(current_world)][index]
				break
			else: index = index + 1
		else: index = index + 1
	MapManage.change_to_map(value)
	#Camera.camera_init()
	#if current_map_data.has("defaultCameraZoom"):
		#Camera.set_camera_zoom(current_map_data["defaultCameraZoom"])
	
	$"/root/Main/DebugUi".updata()

#------------------------
#	Debug
var mouse_pos
var camera_pos
var camera_zoom
