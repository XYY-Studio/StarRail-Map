extends Node2D
const version: String = "0.0.7"

func _process(delta) -> void:
	Global.mouse_pos = get_global_mouse_position()
	Global.camera_pos = Camera.position
	Global.camera_zoom = Camera.zoom
	
func _ready() -> void:
	initial_app()
	MapUi.set_version_lbl(version)

func initial_app() -> void:
	Holo.show_holo(false)
	Global.change_to_world(101)
	Global.change_to_map(10101)
	MapUi.clear_world_option()
	for i in Global.world_json_data["world"]:
		MapUi.add_world_option(i["id"], i["enable"])
		Holo.add_world_option(i["id"])
	MapUi.change_world(101)
	Global.current_status = 0

func switch_to(value: int) -> void:
	match value:
		0: #Map
			MapUi.show_ui(true)
			Holo.show_holo(false)
			Global.set_status(0)
			RenderingServer.set_default_clear_color(Color("CCCCCC"))
		1: #Holo
			MapUi.show_ui(false)
			Holo.show_holo(true)
			Global.set_status(1)
			RenderingServer.set_default_clear_color(Color("111111"))

func show_setting_window(value: bool) -> void:
	if value == $Setting.visible:
		if value == true:
			$Setting.set_visible(false)
	else:
		$Setting.set_visible(value)


#------------------------
#	帧数限制 Frame limit (TODO…)
#
#var background_fps: int = 10
#var foreground_fps: int = 60
## 窗口聚焦判断
#func _notification(what) -> void:
#	if what == NOTIFICATION_WM_MOUSE_ENTER:
#		Engine.max_fps = foreground_fps
#	if what == NOTIFICATION_WM_MOUSE_EXIT:
#		Engine.max_fps = background_fps
#
#	if what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
#		Engine.max_fps = foreground_fps
#	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
#		Engine.max_fps = background_fps
#
#	pass