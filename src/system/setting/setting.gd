extends Window

var setting_data := preload("res://src/system/setting/setting_data.gd").new()

func _ready() -> void:
	setting_data.load_setting()

func set_resolution(id) -> void:
	match id:
		1:
			DisplayServer.window_set_size(Vector2(1920, 1080))
		2:
			DisplayServer.window_set_size(Vector2(1600, 900))
		3:
			DisplayServer.window_set_size(Vector2(1366, 768))
		4:
			DisplayServer.window_set_size(Vector2(1360, 768))
		5:
			DisplayServer.window_set_size(Vector2(1280, 720))

#------------------------
##	Signal

func _on_close_setting_requested() -> void:
	self.set_visible(false)

func _on_update_button_pressed() -> void:
	pass # Replace with function body.

func _on_ui_scale_value_changed(value: float) -> void:
	ProjectSettings.set_setting("display/window/stretch/scale", value)
	setting_data.save_setting("scale", value)

func _on_resolution_option_item_selected(index: int) -> void:
	var res = index
	set_resolution(index)
	match index:
		0:
			$"/root/".set_flag(FLAG_RESIZE_DISABLED, false)
			return
	
	$"/root/".set_flag(FLAG_RESIZE_DISABLED, true)
	setting_data.save_setting("resoltion", res)

func _on_full_screen_button_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		setting_data.save_setting("full_screen", false)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		setting_data.save_setting("full_screen", true)

func _on_lang_option_button_item_selected(index: int) -> void:
	var id = $"TabContainer/{set_general}/Language/OptionButton".get_item_id(index)
	var lang:String
	match id:
		0:
			lang = "zh_CN"
			TranslationServer.set_locale(lang)
		1:
			lang = "zh_TW"
			TranslationServer.set_locale(lang)
		2:
			lang = "en_US"
			TranslationServer.set_locale(lang)
	
	setting_data.save_setting("lang", lang)

func _on_floor_cam_init_button_pressed() -> void:
	Global.seting_init_cam_floor = !Global.seting_init_cam_floor
