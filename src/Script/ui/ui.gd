extends CanvasLayer
const SCR_NAME: String = "ui.gd"

@onready var world_option = $Panel/VBoxContainer/WorldSelectBox/WorldSelect
@onready var map_option = $Panel/VBoxContainer/MapSelectBox/MapSelect

#清空世界选项
func clear_world_option() -> void:
	world_option.clear()
	world_index = -1
	Logger.output(SCR_NAME, "Clear all world option!", 1)

#世界选项
var world_option_text = "{world_%s}"
var world_index: int = -1
func add_world_option(world_id, enable: bool) -> void:
	# world_id 是字符串
	world_option.add_item(world_option_text %world_id, int(world_id))
	world_index += 1
	Logger.output(SCR_NAME, "add world index: " + str(world_index), 0)
	if enable == false:
		world_option.set_item_disabled(world_index, true)
		Logger.output(SCR_NAME, "disable: " + str(world_index), 0)

#更改世界
func change_world(world_id) -> void:
	world_option.select(world_option.get_item_index(world_id))
	
	map_option.clear()
	map_index = -1
	var map_list = MapManage.get_map_list(world_id)
	for i in map_list:
		self.add_map_option(i)
	
	$MapTitle/LblWorld.text = world_option_text %world_id
	var texture_world = $MapTitle/TextureRect
	if world_id == 101:
		texture_world.set_texture(load("res://Resource/img/ico/101.png"))
	elif world_id == 201:
		texture_world.set_texture(load("res://Resource/img/ico/201.png"))
	elif world_id == 301:
		texture_world.set_texture(load("res://Resource/img/ico/301.png"))

#地图
var map_option_text = "{map_%s}"
var map_index: int = -1
func add_map_option(map_id: int) -> void:
	map_index += 1
	map_option.add_item(map_option_text %map_id, map_id)

func change_map(map_id: int) -> void:
	$MapTitle/LblMap.text = map_option_text %map_id

func _on_world_select_item_selected(index):
	var id = world_option.get_item_id(index)
	
	self.change_world(id)
	MapManage.change_world(id)

func _on_map_select_item_selected(index):
	var id = map_option.get_item_id(index)
	
	self.change_map(id)
	MapManage.change_map(id)
