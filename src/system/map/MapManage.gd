extends Node

#@onready var Camera = $"/root/Main/Camera"

func change_to_map(map_id: int) -> void:
	if not Global.current_map_data["multiFloor"]:
		set_map_texture(map_id)

func change_to_floor(index: String) -> void:
	set_map_texture("%s_%s" %[Global.current_map, index])
	#print("change to", index)

#------------------------
#	Other

func get_world_list() -> Array:
	return Global.current_world_data["world"]

func get_map_list(world_id) -> Array:
	return Global.current_map_data["%s" %world_id]

#func get_map_data(index: int) -> Dictionary:
	#return

@onready var maptexture = $"/root/Main/Map"
func set_map_texture(map_id):
	maptexture.set_texture(load("res://Resource/img/map/%s/%s.png" %[Global.current_world, map_id]))
	
	Camera.camera_init()
	if Global.current_map_data.has("defaultCameraZoom"):
		Camera.set_camera_zoom(Global.current_map_data["defaultCameraZoom"])
