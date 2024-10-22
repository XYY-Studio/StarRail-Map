extends Node2D

@onready var world_json_data = Util.get_json_data(FileAccess.open("res://resource/data/world.json", FileAccess.READ))
@onready var map_json_data = Util.get_json_data(FileAccess.open("res://resource/data/map.json", FileAccess.READ))
@onready var Ui = %Ui

func _process(delta) -> void:
	#Debug
	Global.mouse_pos = get_global_mouse_position()
	Global.camera_pos = Camera.position
	
	Global.camera_zoom = Camera.zoom

func _ready() -> void:
	%Setting.set_visible(false)
	
	init()

func init() -> void:
	var err = load_data()
	if err == OK:
		init_ui()
		Ui.set_ui_type(0)
		MapManager.set_map_to("10101")

func load_data() -> Error:
	for i in world_json_data["world"]:
		Global.world_data[i["id"]] = i
		
		for map in map_json_data["map"][i["id"]]:
			Global.map_data[map["id"]] = map
			Global.map_data[map["id"]]["world"] = i["id"]
	
	Global.floorTemp = map_json_data["floorTemplate"]
	print("完成Global Data加载")
	return OK

func init_ui() -> void:
	get_tree().call_group("Ui", "load_data")

func show_setting_window(value: bool) -> void:
	if value == %Setting.visible:
		if value == true:
			%Setting.set_visible(false)
	else:
		%Setting.set_visible(value)
