extends CanvasLayer

func _ready() -> void:
	var ver = ProjectSettings.get_setting("application/config/version", null)
	if ver != null:
		%BtnVersion.set_text("Ver. " + ver)
	else:
		%BtnVersion.set_text("Test Build")

func _on_btn_version_pressed() -> void:
	OS.shell_open("https://github.com/XYY-Studio/StarRail-Map")
