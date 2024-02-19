extends CanvasLayer

@onready var world_option := $Panel/MapControl/WorldSelectBox/WorldSelect
@onready var map_option := $Panel/MapControl/MapSelectBox/MapSelect
@onready var floor_option := $Panel/MapControl/FloorSelectBox/FloorSelect
@onready var floor_anim_player := $Panel/AnimationPlayer
@onready var ui_anim_player := $AnimationPlayer
@onready var trans_bg := $ColorRect
@onready var camera := Camera
@onready var zoom_slider := $ZoomControl/SliderZoom

#------------------------
#	General

func _ready() -> void:
	zoom_slider.set_min(camera.zoom_min)
	zoom_slider.set_max(camera.zoom_max)
	zoom_slider.set_step(camera.zoom_value)
	
	# 奇怪的bug修复
	$Panel._set_size(Vector2(333.0, 216.0))
	$Panel.set_position(Vector2(1587.0, 0.0))

func show_ui(value: bool) -> void:
	if value:
		ui_anim_player.play("show_ui")
	else:
		ui_anim_player.play("hide_ui")

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
	var map_json = Global.map_json_data[str(world_id)]
	clear_map_option()
	Global.change_to_world(world_id)
	for i in map_json:
		if i.has("is_separator"):
			if i["is_separator"]:
				add_map_option(i["id"], true, true)
			else: add_map_option(i["id"], false, true)
		elif i.has("enable") && i["enable"] == false:
			add_map_option(i["id"], false, false)
		else:
			add_map_option(i["id"], false, true)
	
	if map_json[0].has("is_separator"):
		if map_json[0]:
			change_map(int(map_json[1]["id"]))
		else: change_map(int(map_json[0]["id"]))
	else: change_map(int(map_json[0]["id"]))
	world_option._select_int(world_option.get_item_index(world_id))
	
	$MapTitle/LblWorld.text = "{world_%s}" %world_id
	var ico_file: String
	for i in Global.world_json_data["world"]:
		if i["id"] == world_id:
			ico_file = i["logo_path"]
			break
	if ico_file.is_empty() == false:
		$MapTitle/TextureRect.set_texture(load(ico_file))
	else:
		$MapTitle/TextureRect.set_texture(null)
		print("World %s have no Logo." %str(world_id))

#------------------------
#	Map

func clear_map_option() -> void:
	map_option.clear()

func add_map_option(_id: String, is_separator: bool, enable: bool) -> void:
	if is_separator:
		map_option.add_separator("{spt_%s}" %_id)
		return
	map_option.add_item("{map_%s}" %_id, int(_id))
	if !enable:
		var idx = map_option.get_item_index(int(_id))
		map_option.set_item_disabled(idx, !enable)

func change_map(map_id: int) -> void:
	#Transitions
	var tween := create_tween()
	tween.tween_property(trans_bg, "color:a", 1, 0.1)
	await tween.finished
	
	$MapTitle/LblMap.text = "{map_%s}" %map_id
	clear_floor_option()
	Global.change_to_map(map_id)
	var mut_f = Global.current_map_data["multiFloor"]
	show_floor(mut_f)
	if mut_f:
		set_floor_option(Global.current_map_data["floorTemplate"])
		change_floor_option(Global.current_map_data["defaultFloor"])
	
	tween = create_tween()
	tween.tween_property(trans_bg, "color:a", 0, 0.1)
	
#------------------------
#	Floor

func show_floor(enable: bool) -> void:
	if enable == true && floor_option.visible == false:
		floor_anim_player.play("show_floor")
	elif enable == false && floor_option.visible == true:
		floor_anim_player.play("hide_floor")
	
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
#	Camera Zoom
func set_zoom_slider(value: float) -> void:
	zoom_slider.set_value(value)

#------------------------
#	Signal

func _on_world_select_item_selected(index) -> void:
	var id = world_option.get_item_id(index)
	change_world(id)

func _on_map_select_item_selected(index) -> void:
	var id = map_option.get_item_id(index)
	change_map(id)

func _on_floor_select_item_selected(index) -> void:
	var tween := create_tween()
	tween.tween_property(trans_bg, "color:a", 1, 0.1)
	await tween.finished
	
	if not Global.current_map_data["floor"].has("0"):
		MapManage.change_to_floor(str(index + 1))
	else:
		MapManage.change_to_floor(str(index))
	
	tween = create_tween()
	tween.tween_property(trans_bg, "color:a", 0, 0.1)

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

var is_press_version: bool = false
func _on_lbl_version_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and is_press_version == false:
			is_press_version = true
			$LblVersion/Timer.start(0.1)
			OS.shell_open("https://github.com/Xyyaua/StarRail-Map")

func _on_timer_timeout() -> void:
	is_press_version = false
