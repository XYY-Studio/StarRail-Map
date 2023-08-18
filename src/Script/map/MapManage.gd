extends Node
const SCR_NAME: String = "MapManage.gd"

var world_json_file = FileAccess.open("res://Resource/data/world.json", FileAccess.READ)
var map_json_file = FileAccess.open("res://Resource/data/map.json", FileAccess.READ)
@onready var ui = $"/root/Main/Ui"

# Array
var world_data 
var map_data

func _ready() -> void:
	# Logger.output(SCR_NAME,  "MapManage Ready!", 1)
	world_data = self.get_world_list()
	Logger.output(SCR_NAME, "Get world data: " + str(world_data), 0)
	
	


func cheak_world(world: String) -> bool:
	var world_enable = Util.get_json_data(world_json_file)["%s" %world]["enable"]
	return world_enable

func change_world(world_id: int) -> void:
	Global.now_world = world_id
	Logger.output(SCR_NAME, "change to world: " + str(world_id), 1)
	
	ui.change_world(world_id)
	map_data = get_map_list(world_id)
	self.change_map(int(map_data[0]))


var instance_map
func change_map(map_id: int) -> void:
	Global.now_map = map_id
	Logger.output(SCR_NAME, "change to map: " + str(map_id), 1)
	
	ui.change_map(map_id)
	instance_map = "res://src/map/" + str(Global.now_world) + "/" + "10101.tscn"
	# get_node("/root/Main/Map/%s" %Global.now_map).free()
	$"/root/Main/Camera".camera_init()


func get_world_list() -> Array:
	return Util.get_json_data(world_json_file)["World"]

func get_map_list(world_id) -> Array:
	return Util.get_json_data(map_json_file)["%s" %world_id]["map"]
