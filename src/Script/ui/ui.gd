extends CanvasLayer

@onready var world_option = $Panel/MapControl/WorldSelectBox/WorldSelect
@onready var map_option = $Panel/MapControl/MapSelectBox/MapSelect
@onready var floor_option = $Panel/MapControl/FloorSelectBox/FloorSelect
@onready var anim_player = $Panel/AnimationPlayer

#------------------------
#	World

#清空世界选项
func clear_world_option() -> void:
	world_option.clear()

func add_world_option(world_id, enable: bool) -> void:
	world_option.add_item("{world_%s}" %world_id, int(world_id))
	if not enable:
		world_option.set_item_disabled(
			world_option.get_item_index(int(world_id)),
			true
		)

func change_world(world_id) -> void:
	clear_map_option()
	Global.change_to_world(world_id)
	for i in Global.map_json_data[str(world_id)]:
		add_map_option(i["id"])
	
	$MapTitle/LblWorld.text = "{world_%s}" %world_id
	var ico_file
	for i in Global.world_json_data["world"]:
		if i["id"] == world_id:
			ico_file = i["logo_path"]
			break
	if ico_file != null:
		$MapTitle/TextureRect.set_texture(load(ico_file))
	else:
		print("World %s have no Logo." %str(world_id))
	
	change_map(int(Global.map_json_data[str(world_id)][0]["id"]))

#------------------------
#	Map

func clear_map_option() -> void:
	map_option.clear()

func add_map_option(map_id: String) -> void:
	map_option.add_item("{map_%s}" %map_id, int(map_id))

func change_map(map_id: int) -> void:
	$MapTitle/LblMap.text = "{map_%s}" %map_id
	clear_floor_option()
	Global.change_to_map(map_id)
	var mut_f = Global.current_map_data["multiFloor"]
	show_floor(mut_f)
	if mut_f:
		set_floor_option(Global.current_map_data["floorTemplate"])
		change_floor_option(Global.current_map_data["defaultFloor"])

#------------------------
#	Floor

func show_floor(enable: bool) -> void:
	if enable == true && floor_option.visible == false:
		anim_player.play("show_floor")
	elif enable == false && floor_option.visible == true:
		anim_player.play("hide_floor")
	
	floor_option.set_visible(enable)

func set_floor_option(floor_type: String) -> void:
	for i in Global.map_json_data["floorTemplate"][floor_type]:
		floor_option.add_item("{floor_%s}" %i)

func change_floor_option(index) -> void:
	var num = 0
	for i in Global.current_map_data["floor"]:
		if i == index:
			MapManage.change_to_floor(str(index))
			floor_option.select(num)
			break
		num += 1

func clear_floor_option() -> void:
	floor_option.clear()

#------------------------
#	Signal

func _on_world_select_item_selected(index) -> void:
	var id = world_option.get_item_id(index)
	change_world(id)

func _on_map_select_item_selected(index) -> void:
	var id = map_option.get_item_id(index)
	change_map(id)

func _on_floor_select_item_selected(index) -> void:
	if not Global.current_map_data["floor"].has("0"):
		MapManage.change_to_floor(str(index + 1))
	else:
		MapManage.change_to_floor(str(index))

func _on_btn_setting_pressed() -> void:
	$"/root/Main".show_setting_window(true)

func _on_btn_holo_pressed() -> void:
	pass # Replace with function body.

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
