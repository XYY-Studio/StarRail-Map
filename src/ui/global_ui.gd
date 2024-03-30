extends CanvasLayer

func _ready() -> void:
	$LblVersion.set_text(Global.version)

var is_press_version: bool = false
func _on_lbl_version_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and is_press_version == false:
			is_press_version = true
			$LblVersion/Timer.start(0.1)
			OS.shell_open("https://github.com/Xyyaua/StarRail-Map")

func _on_timer_timeout() -> void:
	is_press_version = false
