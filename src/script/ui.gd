extends CanvasLayer
const SRC_NAME = "ui.gd"

var res :int = 2
var scaling :bool

func _ready():
	pass

func  _physics_process(delta):
	pass

func _on_resolution_select_item_selected(index):
	if index == 0:
		print("select 1920 x 1080")
		res = 0
	elif index == 1:
		print("select 1600 x 900")
		res = 1
	elif index == 2:
		print("select 1280 x 720")
		res = 2

func _on_resolution_confirm_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED || DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if res == 0:
		DisplayServer.window_set_size(Vector2(1920, 1080))
	elif res == 1:
		DisplayServer.window_set_size(Vector2(1600, 900))
	elif res == 2:
		DisplayServer.window_set_size(Vector2(1280, 720))

func _on_test_button_pressed():
	print("A test message")
	# print(JsonUtil.map(101))

#zoom retransmission
#func _on_mapzoom_map_zoom_slider(value):
#	emit_signal("map_zoom_retransmission", value)

var select_world
func _on_opbtn_world_item_selected(index):
	if index == 1:
		select_world = 1
	if index == 2:
		select_world = 2
	if index == 3:
		select_world = 3
