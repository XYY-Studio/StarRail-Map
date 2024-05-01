extends CanvasLayer

@onready var main = $"/root/Main"
@onready var world_select = $Panel/Control/VBoxContainer/WorldSelect

#------------------------
#region General

func _ready() -> void:
	$Panel._set_position(Vector2(1700.0, 0))

func show_holo_ui(value: bool) -> void:
	if value:
		var idx
		if Global.current_world == 100:
			idx = world_select.get_item_index(101)
		else:
			idx = world_select.get_item_index(Global.current_world)
		world_select.select(idx)
	set_visible(value)

#endregion

#------------------------
#region World

func add_world_option(id: int) -> void:
	for i in Global.world_json_data["world"]:
		if i["id"] == id && i["holo"]["enable"]:
			world_select.add_item("{world_%s}" %str(id), id)
	var idx = world_select.get_index(id)
	#world_select.set_item_disabled()

func change_world(id: int) -> void:
	pass

#endregion

#------------------------
#region Signal

func _on_btn_back_to_map_pressed() -> void:
	main.switch_to(0)

func _on_world_select_item_selected(index: int) -> void:
	#var id = world_select.get_item_id(index)
	#MapUi.change_world(id)
	#for i in Global.world_json_data["world"]:
		#if i["id"] == id:
			#if i["holo"]["img"].size() == 1 :
				#MapManage.set_holo_texture(i["holo"]["img"][0])
		#
			#print(i["holo"]["img"].size())
	pass

#endregion
