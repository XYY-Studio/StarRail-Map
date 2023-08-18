extends CanvasLayer
const SCR_NAME: String = "debug_ui.gd"

var mouse_pos
var camera_pos
var camera_zoom

@onready var lbl_mouse_pos = $LblBox/mousePostion
@onready var lbl_camera_pos = $LblBox/cameraPostion
@onready var lbl_camera_zoom = $LblBox/cameraZoom

var text_mouse_pos = "MousePostion: "
var text_camera_pos = "CameraPostion: "
var text_camera_zoom = "CameraZoom: "

func _process(delta):
	mouse_pos = str(Global.mouse_pos)
	camera_pos = str(Global.camera_pos)
	camera_zoom = str(Global.camera_zoom)
	
	lbl_mouse_pos.text = text_mouse_pos + mouse_pos
	lbl_camera_pos.text = text_camera_pos + camera_pos
	lbl_camera_zoom.text = text_camera_zoom + camera_zoom

@onready var index = $LblBox/HBoxContainer/index.text
@onready var world_select = $"../Ui/Panel/VBoxContainer/WorldSelectBox/WorldSelect"
func _on_disable_pressed():
	index = $LblBox/HBoxContainer/index.text
	world_select.set_item_disabled(int(index), true)
	Logger.output(SCR_NAME, "Disable index: " + index, 0)

func _on_enable_pressed():
	index = $LblBox/HBoxContainer/index.text
	world_select.set_item_disabled(int(index), false)
