extends CanvasLayer

var ui_type

enum UI_TYPE{
	IN_MAP = 0,
	IN_WORLD = 1,
	IN_3D_EXTRA = 2,
	IN_2D_EXTRA = 3
}

func _ready() -> void:
	get_tree().call_group("Ui", "_set_visible", false)
	#for c in $".".get_children():
		#c.set_visible(false)

func set_ui_type(value) -> void:
	#if ui_type != null:
		#for i in $Ui.get_children():
			#i.queue_free()
	get_tree().call_group("Ui", "_set_visible", false)
	
	if value == UI_TYPE.IN_MAP || 0:
			$MapUi._set_visible(true)
			$MapUi.change_world("101")
	elif value == UI_TYPE.IN_WORLD || 1:
			pass
	elif value == UI_TYPE.IN_2D_EXTRA || 2:
			pass
	elif value == UI_TYPE.IN_3D_EXTRA || 3:
			pass
		
	else:
			return
	
	ui_type = value

func change_world(id) -> void:
	if ui_type == 0:
		pass
	elif ui_type == 1:
		pass
	elif ui_type == 2:
		pass
	elif ui_type == 3:
		pass
		
	else:
		return

func change_map(id) -> void:
	pass
