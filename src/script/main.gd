extends Node2D
const SRC_NAME = "main.gd"

#-------------------------
#	Application Config

var min_window_x = 480
var min_window_y = 270
var lang = "zh"

func _ready():
	DisplayServer.window_set_min_size(Vector2(min_window_x, min_window_y))
	
	#i18n
	TranslationServer.set_locale(lang)
	
	#test
	Logger.output(SRC_NAME, "Test info", 0)

#-------------------------
#	Map Zoom Slider

@onready var SLIDER = $"TEST_InlineUI/VBoxContainer/map-zooma/zoom-slider"
var change_zoom = 1

func _on_zoomout_pressed():
	SLIDER.value -= change_zoom

func _on_zoomin_pressed():
	SLIDER.value += change_zoom

func _on_zoomslider_value_changed(value):
	
	var v = str(value)
	print("Slider: " + v)

#-------------------------
#	Map Managed

var select_world
func _on_opbtn_world_item_selected(index):
	if index == 1:
		select_world = 1
	if index == 2:
		select_world = 2
	if index == 3:
		select_world = 3

#-------------------------
#	Debug

@onready var cam_var = get_node("Camera2D")
@onready var CAM = $Camera2D
@onready var DEBUG_CamPos = $TEST_InlineUI/DEBUGLblVBox/CamPos
@onready var DEBUG_CamZoom = $TEST_InlineUI/DEBUGLblVBox/CamZoom
@onready var DEBUG_CamSpeed = $TEST_InlineUI/DEBUGLblVBox/CamSpeed
@onready var DEBUG_MousePos = $TEST_InlineUI/DEBUGLblVBox/MousePos
var debug_CamPosLbl = "CamPos: "
var debug_CamStartPosLbl = "CamStartPos: "
var debug_StartPosLbl = "StartPos: "
var debug_CamZoomLbl = "CamZoom: "
var debug_CamScaleNumLbl = "CamScaleNum: "
var debug_MousePosLbl = "MousePos: "

func _process(delta):
	# print(CAM.position)	$LblVBox/CamPos.text = debug_CamZoomLbl
	DEBUG_CamPos.text = debug_CamPosLbl + str(CAM.position) + "," + debug_CamStartPosLbl + str(cam_var.startCamPos) + "," + debug_StartPosLbl + str(cam_var.startPos)
	DEBUG_CamZoom.text = debug_CamZoomLbl + str(CAM.zoom)
	DEBUG_CamSpeed.text = debug_CamScaleNumLbl + str(cam_var.scaleNum)
	DEBUG_MousePos.text = debug_MousePosLbl + str(get_viewport().get_mouse_position())
	pass
