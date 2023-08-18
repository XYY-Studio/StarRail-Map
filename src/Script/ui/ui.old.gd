extends CanvasLayer
const SRC_NAME: String = "ui.gd"

#var map = ["{map_10101}", "{map_10102}", "{map_10103}"]
var world_map = {
	"101": {
		"id": "101",
		"map": ["10101", "10102", "10103"]
	},
	"201": { 
		"id": "201",
		"map": ["20101", "20102", "20103"]
	},
	"301": { 
		"id": "301",
		"map": ["30101", "30102", "30103"]
	}
}

var texture_1 = load("res://Resource/img/ico/101.png")
var texture_2 = load("res://Resource/img/ico/201.png")
var texture_3 = load("res://Resource/img/ico/301.png")

var lbl_map
var lbl_world

var random_out_map
var random_out_world

var json = JSON.new()

func _on_btn_debug_pressed():
	randomize()
	var map_data
	
	# for i in range(20):
		# print(get_map())
		# $MapTitle/LblMap.text = get_map()
	var json_string = JSON.stringify(world_map)
	var map01 = str(random_map())
	
	# var err = json.parse(map01)
	# var json_file = FileAccess.open("res://Resource/data/map.json", FileAccess.READ)
	var json_file =FileAccess.get_file_as_string("res://Resource/data/map.json")
	var json_parstr = json.parse_string(json_file)
	var err = json.parse(json_file)
	if err != null:
		map_data = json.data
		if typeof(map_data) == TYPE_DICTIONARY:
			Logger.output(SRC_NAME, "Random map data: " + str(map_data), 1)
			
		else:
			print(typeof(map_data))
			Logger.output(SRC_NAME, "Unexpected data: " + str(map_data), 3)
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	
	random_out_world = map_data["id"]
	random_out_map = map_data["map"][randi() % map_data["map"].size()]
	
	lbl_world = "{world_%s}" %random_out_world
	lbl_map = "{map_%s}" %random_out_map
	
	Logger.output(SRC_NAME, "Random world: " + random_out_world, 1)
	Logger.output(SRC_NAME, "Random map: " + random_out_map, 1)
	
	$MapTitle/LblWorld.text = lbl_world
	$MapTitle/LblMap.text = lbl_map
	
	updata_ui()

func random_map():
	#var random_map = map[randi() % map.size()]
	#return random_map
	
	var random_world = world_map.values()[randi() % world_map.size()]
	#print(random_world)
	return random_world

func updata_ui():
	var world = $Panel/VBoxContainer/WorldSelectBox/WorldSelect
	# var map = $Panel/VBoxContainer/Control/MapSelect
	var world_ico = $MapTitle/TextureRect
	
	if random_out_world == "101":
		world.selected = 1
		world_ico.set_texture(texture_1)
	elif random_out_world == "201":
		world.selected = 2
		world_ico.set_texture(texture_2)
	elif random_out_world == "301":
		world.selected = 3
		world_ico.set_texture(texture_3)

func _on_world_select_item_selected(index):
	match index:
		0:
			Logger.output(SRC_NAME, "Select world 100", 0)
		1:
			Logger.output(SRC_NAME, "Select world 101", 0)
		2:
			Logger.output(SRC_NAME, "Select world 201", 0)
		3:
			Logger.output(SRC_NAME, "Select world 301", 0)

