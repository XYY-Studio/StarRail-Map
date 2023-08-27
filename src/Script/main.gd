extends Node2D
const SCR_NAME: String = "main.gd"

func _ready() -> void:
	#初始化了属于是
	$Ui.clear_world_option()
	for i in MapManage.world_data:
		var enable = MapManage.cheak_world(i)
		if enable == true:
			$Ui.add_world_option(i, true)
		else:
			$Ui.add_world_option(i, false)
	
	MapManage.change_world(101)


func _process(delta) -> void:
	Global.mouse_pos = get_global_mouse_position()#get_viewport().get_mouse_position()
	Global.camera_pos = $Camera.position
	Global.camera_zoom = $Camera.zoom

#------------------------
#	检查更新
func cheak_updata() -> void:
	# $HTTPRequest.request("https://raw.githubusercontent.com/Xyyaua/Map-data-sr/main/version.json")
	# $HTTPRequest.request_completed.connect(requst_updata)
	pass

func requst_updata(result, response_code, headers, body) -> void:
	Logger.output(SCR_NAME, "Get result: " + str(result), 1)
	Logger.output(SCR_NAME, "Get code: " + str(response_code), 1)
	Logger.output(SCR_NAME, "Get head: " + str(headers), 1)
	Logger.output(SCR_NAME, "Get body: " + str(body.get_string_from_utf8()), 1)

#------------------------
#	帧数限制

var background_fps: int = 10
var foreground_fps: int = 60
# 窗口聚焦判断
func _notification(what) -> void:
#	if what == NOTIFICATION_WM_MOUSE_ENTER:
#		Engine.max_fps = foreground_fps
#	if what == NOTIFICATION_WM_MOUSE_EXIT:
#		Engine.max_fps = background_fps
	
#	if what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
#		Engine.max_fps = foreground_fps
#	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
#		Engine.max_fps = background_fps
	
	pass
