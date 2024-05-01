extends Node

#------------------------
#	Data
var map_data :Dictionary
var world_data :Dictionary
var floorTemp :Dictionary
var current_map
var current_map_data :Dictionary
var current_map_list :Array
var current_world
var current_world_data :Dictionary
var current_floor

#------------------------
#	Settings
var setting_init_cam_floor :bool = true
var setting_frosted_glass :bool = true

#------------------------
#	Debug
var mouse_pos
var camera_pos
var camera_zoom
