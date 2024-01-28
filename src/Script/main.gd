extends Node2D
const SCR_NAME: String = "main.gd"

func _ready() -> void:
	#为了方便所以在这里添加地图
	$Ui.clear_world_option()
	for i in MapManage.world_data:
		var enable = MapManage.cheak_world(i)
		if enable == true:
			$Ui.add_world_option(i, true)
		else:
			$Ui.add_world_option(i, false)
	
	MapManage.change_world(101)
	

func _process(delta) -> void:
	Global.mouse_pos = get_global_mouse_position()
	Global.camera_pos = $Camera.position
	Global.camera_zoom = $Camera.zoom

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
