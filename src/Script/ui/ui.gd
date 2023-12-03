extends CanvasLayer
const SCR_NAME: String = "ui.gd"

@onready var world_option = $Panel/VBoxContainer/WorldSelectBox/WorldSelect
@onready var map_option = $Panel/VBoxContainer/MapSelectBox/MapSelect

#------------------------
#	World

#清空世界选项
func clear_world_option() -> void:
	world_option.clear()
	world_index = -1
	Logger.output(SCR_NAME, "Clear all world option!", 0)

var world_option_text: String = "{world_%s}"
var world_index: int = -1
func add_world_option(world_id, enable: bool) -> void:
	# world_id 是字符串
	world_option.add_item(world_option_text %world_id, int(world_id))
	world_index += 1
	Logger.output(SCR_NAME, "add world index: " + str(world_index), 0)
	if enable == false:
		world_option.set_item_disabled(world_index, true)
		Logger.output(SCR_NAME, "disable: " + str(world_index), 0)

func change_world(world_id) -> void:
	world_option.select(world_option.get_item_index(world_id))
	
	map_option.clear()
	map_index = -1
	var map_list = MapManage.get_map_list(world_id)
	for i in map_list:
		add_map_option(i)
	
	$MapTitle/LblWorld.text = world_option_text %world_id
	var texture_world = $MapTitle/TextureRect
	texture_world.set_texture(load("res://Resource/img/ico/%s.png" %world_id))

#------------------------
#	Map

var map_option_text = "{map_%s}"
var map_index: int = -1
func add_map_option(map_id: int) -> void:
	map_index += 1
	map_option.add_item(map_option_text %map_id, map_id)

func change_map(map_id: int) -> void:
	$MapTitle/LblMap.text = map_option_text %map_id

#------------------------
#	Floor

@onready var floor_select = $Panel/VBoxContainer/FloorSelectBox/FloorSelect
func show_floor(enable: bool) -> void:
	floor_select.visible = enable

func set_floor_option(floor_type: int) -> void:
	floor_select.clear()
	match floor_type:
		0:
			floor_select.add_item("F1", 1)
			floor_select.add_item("F2", 2)
		1:
			floor_select.add_item("B1", 1)
			floor_select.add_item("F1", 2)
		2:
			floor_select.add_item("B1", 1)
			floor_select.add_item("F1", 2)
			floor_select.add_item("F2", 3)
	return

func change_floor_option(index: int) -> void:
	floor_select.select(index)

func clear_floor_option() -> void:
	floor_select.clear()

#------------------------
#	Transitions

@onready var anim = $AnimationPlayer
func anim_play(name: String) -> void:
	anim.play(name)

#------------------------
#	Signal

func _on_world_select_item_selected(index) -> void:
	var id = world_option.get_item_id(index)
	change_world(id)
	MapManage.change_world(id)

func _on_map_select_item_selected(index) -> void:
	var id = map_option.get_item_id(index)
	change_map(id)
	MapManage.change_map(id)

func _on_floor_select_item_selected(index) -> void:
	MapManage.change_floor(str(index + 1))
