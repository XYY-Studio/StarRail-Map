extends Window

func _on_close_setting_requested() -> void:
	self.set_visible(false)


func _on_update_button_pressed() -> void:
	pass # Replace with function body.


func _on_ui_scale_value_changed(value: float) -> void:
	ProjectSettings.set_setting("display/window/stretch/scale", value)


func _on_resolution_option_item_selected(index: int) -> void:
	match index:
		0:
			$"/root/".set_flag(FLAG_RESIZE_DISABLED, false)
			return
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
	
	$"/root/".set_flag(FLAG_RESIZE_DISABLED, true)

func _on_button_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_lang_option_button_item_selected(index: int) -> void:
	var id = $"TabContainer/{set_general}/Language/OptionButton".get_item_id(index)
	match id:
		0:
			TranslationServer.set_locale("zh_CN")
		1:
			TranslationServer.set_locale("zh_TW")
		2:
			TranslationServer.set_locale("en_US")
