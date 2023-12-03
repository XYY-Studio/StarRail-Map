extends Node
const SCR_NAME: String = "MapManage.gd"

var world_json_file = FileAccess.open("res://Resource/data/world.json", FileAccess.READ)
var map_json_file = FileAccess.open("res://Resource/data/map.json", FileAccess.READ)
@onready var ui = $"/root/Main/Ui"

var world_json_data
var map_json_data

# Array
var world_data
var map_data

func _ready() -> void:
	world_json_data = Util.get_json_data(world_json_file)
	map_json_data = Util.get_json_data(map_json_file)
	world_data = get_world_list()
	Logger.output(SCR_NAME, "Get world data: " + str(world_data), 0)

#------------------------
#	World

func cheak_world(world: String) -> bool:
	var world_enable = world_json_data["%s" %world]["enable"]
	return world_enable

func change_world(world_id: int) -> void:
	Global.now_world = world_id
	Logger.output(SCR_NAME, "change to world: " + str(world_id), 1)
	
	ui.change_world(world_id)
	map_data = get_map_list(world_id)
	change_map(int(map_data[0]))

#------------------------
#	Map

var now_map_data

func change_map(map_id: int) -> void:
	$"/root/Main/Ui".anim_play("change_map")
	
	Global.now_map = map_id
	Logger.output(SCR_NAME, "change to map: " + str(map_id), 1)
	now_map_data = map_json_data[str(Global.now_world)][str(map_id)]
	
	$"/root/Main/Debug_ui".updata()
	
	if check_floor(map_id) == true:
		ui.show_floor(true)
		var map_default_floor = now_map_data["defaultFloor"]
		match now_map_data["floorTemplate"]:
			"0":
				ui.set_floor_option(0)
				Global.floor_type = 0
				change_floor(map_default_floor)
				ui.change_floor_option(int(map_default_floor) - 1)
				return
			"1":
				ui.set_floor_option(1)
				Global.floor_type = 1
				change_floor(str(int(map_default_floor) + 1))
			"2":
				ui.set_floor_option(2)
				Global.floor_type = 2
				change_floor(str(int(map_default_floor) + 1))
		
		ui.change_floor_option(int(map_default_floor))
	else:
		ui.show_floor(false)
		set_map_texture(map_id)
	
	ui.change_map(map_id)
	$"/root/Main/Camera".camera_init()

#------------------------
#	Floor

func check_floor(map_id) -> bool:
	var map_floor = now_map_data["multiFloor"]
	Logger.output(SCR_NAME, "check multi floor of %s is " %map_id + str(map_floor), 0)
	return map_floor

func change_floor(_floor: String) -> void:
	if check_floor(Global.now_map) == true:
		#暂时解决方案
		# var map_path: String
		var change_floor_string = str(Global.now_map) + "_" + _floor
		set_map_texture(change_floor_string)
		
	else:
		Logger.output(SCR_NAME, "Cannot change the floor because this map have not multi floor!", 2)

#------------------------
#	Other

func get_world_list() -> Array:
	return world_json_data["world"]

func get_map_list(world_id) -> Array:
	return map_json_data["%s" %world_id]["map"]

@onready var maptexture = $"/root/Main/Map"
func set_map_texture(map_id):
	var world_path: String = "res://Resource/img/map/%s/" %Global.now_world
	maptexture.set_texture(load(world_path + "%s.png" %map_id))
