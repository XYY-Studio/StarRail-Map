extends CanvasLayer

var mouse_pos
var camera_pos
var camera_zoom

@onready var lbl_mouse_pos = $LblBox/mousePostion
@onready var lbl_camera_pos = $LblBox/cameraPostion
@onready var lbl_camera_zoom = $LblBox/cameraZoom
@onready var lbl_world_and_map = $"LblBox/world and map"

var text_mouse_pos = "MousePostion: "
var text_camera_pos = "CameraPostion: "
var text_camera_zoom = "CameraZoom: "
var text_world_and_map = "NowWorld|Map: {0}|{1}"

func _process(delta):
	mouse_pos = str(Global.mouse_pos)
	camera_pos = str(Global.camera_pos)
	camera_zoom = str(Global.camera_zoom)
	
	lbl_mouse_pos.text = text_mouse_pos + mouse_pos
	lbl_camera_pos.text = text_camera_pos + camera_pos
	lbl_camera_zoom.text = text_camera_zoom + camera_zoom

func updata() -> void:
	lbl_world_and_map.text = text_world_and_map.format([str(Global.now_world), str(Global.now_map)])

@onready var index = $LblBox/HBoxContainer/indexInput.text
@onready var world_select = $"../Ui/Panel/VBoxContainer/WorldSelectBox/WorldSelect"
func _on_disable_pressed():
	index = $LblBox/HBoxContainer/indexInput.text
	world_select.set_item_disabled(int(index), true)
	print("Disable index: " + index)

func _on_enable_pressed():
	index = $LblBox/HBoxContainer/indexInput.text
	world_select.set_item_disabled(int(index), false)
	print("Enable index: " + index)

func _on_show_floor_pressed():
	$"../Ui".show_floor(true)

func _on_hide_floor_pressed():
	$"../Ui".show_floor(false)
