extends Control

@onready var world_option := $Panel/MapControl/WorldSelectBox/WorldSelect
@onready var map_option := $Panel/MapControl/MapSelectBox/MapSelect
@onready var floor_option := $Panel/MapControl/FloorSelectBox/FloorSelect
@onready var floor_anim_player := $Panel/AnimationPlayer
@onready var ui_anim_player := $AnimationPlayer
@onready var trans_bg := $ColorRect
@onready var camera := Camera
@onready var zoom_slider := $ZoomControl/SliderZoom

var trtime = 0.1

#------------------------
#region General

func _ready() -> void:
	zoom_slider.set_min(camera.zoom_min)
	zoom_slider.set_max(camera.zoom_max)
	zoom_slider.set_step(camera.zoom_value)
	
	# 奇怪的bug修复
	$Panel._set_size(Vector2(333.0, 216.0))
	$Panel.set_position(Vector2(1570.0, 20.0))

#func _process(delta: float) -> void:
	#$ZoomControl/SliderZoom.set_value(Camera._zoom)

func load_data() -> void:
	clear_world_option()
	for i in Global.world_data:
		add_world_option(Global.world_data[i]["id"], Global.world_data[i]["enable"])
	
	print("完成Ui Data加载")

func _set_visible(value: bool) -> void:
	$".".set_visible(value)
	#trans_bg.visible = false

func set_frosted_glass(value: bool) -> void:
	var panel_shader = $Panel.material
	if value:
		panel_shader.set_shader_parameter("lod", 4.0)
	else:
		panel_shader.set_shader_parameter("lod", 0.0)

#endregion

#------------------------
#region Transitions

func transition_start(time_s: float) -> void:
	var tween := create_tween()
	tween.tween_property(trans_bg, "color:a", 1, time_s)

func transition_end(time_s: float) -> void:
	var tween := create_tween()
	tween.tween_property(trans_bg, "color:a", 0, time_s)

#endregion

#------------------------
#region World

func add_world_option(world_id, enable: bool) -> void:
	world_option.add_item("{world_%s}" %world_id, int(world_id))
	if not enable:
		world_option.set_item_disabled(world_option.get_item_index(int(world_id)), true)

func change_world(world_id: String) -> void:
	clear_map_option()
	Global.current_map_list = []
	Global.current_world = world_id as int
	Global.current_world_data = Global.world_data[world_id]
	var map = Global.map_data
	for i in map:
		var map_data = map[i]
		if map_data["world"] == world_id:
			Global.current_map_list.append(i)
			
			if map_data.has("is_separator"):
				if map_data["is_separator"]:
					add_map_option(map_data["id"], true, true)
				else: add_map_option(map_data["id"], false, true)
			elif map_data.has("enable") && map_data["enable"] == false:
				add_map_option(map_data["id"], false, false)
			else:
				add_map_option(map_data["id"], false, true)
	
	if len(Global.current_map_list[0]) == 5:
		change_map(Global.current_map_list[0])
	else:
		change_map(Global.current_map_list[1])
	world_option._select_int(world_option.get_item_index(int(world_id)))
	
	$MapTitle/LblWorld.text = "{world_%s}" %world_id
	var ico_file: String = Global.world_data[world_id]["logo_path"]
	if ico_file.is_empty() == false:
		$MapTitle/TextureRect.set_texture(load(ico_file))
	else:
		$MapTitle/TextureRect.set_texture(null)
		print("World %s 没有Logo." %str(world_id))

#清空世界选项
func clear_world_option() -> void:
	world_option.clear()

#endregion

#------------------------
#region Map

func add_map_option(_id: String, is_separator: bool, enable: bool) -> void:
	if is_separator:
		map_option.add_separator("{spt_%s}" %_id)
		return
	map_option.add_item("{map_%s}" %_id, int(_id))
	if !enable:
		var idx = map_option.get_item_index(int(_id))
		map_option.set_item_disabled(idx, !enable)

func change_map(map_id) -> void:
	$MapTitle/LblMap.text = "{map_%s}" %map_id
	transition_start(trtime)
	await get_tree().create_timer(0.1).timeout
	
	clear_floor_option()
	Global.current_map = map_id
	Global.current_map_data = Global.map_data[str(map_id)]
	
	camera.reset_camera()
	
	var f = Global.current_map_data["multiFloor"]
	show_floor(f)
	if f:
		set_floor_option(Global.current_map_data["floorTemplate"])
		change_floor(Global.current_map_data["defaultFloor"])
		return
	MapManager.set_map_to(str(map_id))
	
	transition_end(trtime)

func clear_map_option() -> void:
	map_option.clear()

#endregion

#------------------------
#region Floor

func show_floor(enable: bool) -> void:
	if enable == true && floor_option.visible == false:
		floor_anim_player.play("show_floor")
	elif enable == false && floor_option.visible == true:
		floor_anim_player.play("hide_floor")
	
	floor_option.set_visible(enable)

func set_floor_option(floor_type: String) -> void:
	for i in Global.floorTemp[floor_type]:
		floor_option.add_item("{floor_%s}" %i)

func change_floor(index: String) -> void:
	Global.current_floor = index
	
	MapManager.set_map_to(Global.current_map_data["floor"][int(index)])
	floor_option.select(int(index))
	transition_end(trtime)

func clear_floor_option() -> void:
	floor_option.clear()

#endregion

#------------------------
#region Camera Zoom

func set_zoom_slider(value: float) -> void:
	zoom_slider.set_value(value)

#endregion

#------------------------
#region Signal

func _on_world_select_item_selected(index) -> void:
	var id = world_option.get_item_id(index)
	change_world(str(id))

func _on_map_select_item_selected(index) -> void:
	var id = map_option.get_item_id(index)
	change_map(id)
	
	print("Ui0 选择地图%s" %id)

func _on_floor_select_item_selected(index) -> void:
	transition_start(trtime)
	await get_tree().create_timer(0.1).timeout
	
	var id = floor_option.get_item_id(index)
	change_floor(str(index))
	
	if Global.setting_init_cam_floor == true:
		if Global.current_map_data.has("defaultCameraZoom"):
			camera.init_position()
			set_zoom_slider(Global.current_map_data["defaultCameraZoom"])
		else: 
			camera.init_camera()
	print("Ui0 选择楼层id%s, index: %s" %[id, index])

func _on_btn_setting_pressed() -> void:
	$"/root/Main".show_setting_window(true)

func _on_btn_holo_pressed() -> void:
	$"/root/Main".switch_to(1)

func _on_btn_exit_pressed() -> void:
	get_tree().quit()

func _on_btn_zoom_out_pressed() -> void:
	camera.zoom_out()

func _on_slider_zoom_value_changed(value: float) -> void:
	camera.set_camera_zoom(value)

func _on_btn_zoom_in_pressed() -> void:
	camera.zoom_in()

func _on_btn_reset_camera_pressed() -> void:
	camera.reset_camera()

#endregion
