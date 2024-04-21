extends Node

@onready var maptexture = $"/root/Main/Map"

#func change_to_world(id) -> void:
	#pass

func set_map_to(id: String) -> void:
	var le = len(id)
	if le == 5:
		var map = Global.map_data[id]
		set_map_texture(map["path"])
	else:
		set_map_texture(Global.current_map_data["path"] + id + Global.current_map_data["suffix"] )
	

func set_map_texture(path :String) -> void:
	maptexture.set_texture(load(path))
